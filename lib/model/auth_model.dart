import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final db = Firestore.instance;
  StorageReference firebaseStorageRef;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  FirebaseUser user;
  Map<String, dynamic> userData = Map();
  String url_image;

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  bool isLoggedIn() {
    return user != null ? true : false;
  }

  Future<Null> signInWithGoogle(
      {VoidCallback onSuccess, VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    GoogleSignInAccount googleUser = googleSignIn.currentUser;
    if (googleUser == null) {
      googleUser = await googleSignIn.signInSilently();
    }
    if (googleUser == null) {
      googleUser = await googleSignIn.signIn();
    }

    if (await _auth.currentUser() == null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      user = await _auth.signInWithCredential(authCredential);

      DocumentSnapshot userDatabase =
          await db.collection('usuarios').document(user.uid).get();

      if (userDatabase.data == null) {
        Map<String, dynamic> userGoogleData = {
          'nome': user.displayName,
          'email': user.email,
          'url_img_perfil': user.photoUrl,
          'telefone': user.phoneNumber,
        };
        await _saveInDatabase(userGoogleData);
      } else {
        this.userData = userDatabase.data;
      }
    } else {
      DocumentSnapshot userDatabase =
          await db.collection('usuarios').document(user.uid).get();
      this.userData = userDatabase.data;
    }
    await _loadCurrentUser();
    onSuccess();
    isLoading = false;
    notifyListeners();
  }

  void signUp(
      {Map<String, dynamic> userData,
      String password,
      VoidCallback onSuccess,
      VoidCallback onFail,
      File image}) {
    isLoading = true;
    notifyListeners();
    print(userData["email"]);
    print(password);
    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: password)
        .then((user) async {
      user = user;

      if (image != null) await _uploadPic(image);

      await _saveInDatabase(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    await googleSignIn.signOut();

    userData = Map();
    user = null;

    notifyListeners();
  }

  void signIn(
      {String email,
      String password,
      VoidCallback onSuccess,
      VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      user = user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPassword(String email) {
    _auth.sendPasswordResetEmail(email: email).then((_) {}).catchError((e) {
      print(e);
    });
  }

  void updateUser(
      {Map<String, dynamic> userData,
      VoidCallback onSuccess,
      VoidCallback onFail,
      File image}) async {
    isLoading = true;
    notifyListeners();

    await _loadCurrentUser();

    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = userData['nome'];
    info.photoUrl = userData['url_img_perfil'];

    user.updateProfile(info).then((_) async {
      if (image != null) await _uploadPic(image);

      await _updateUserData(userData);

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> _updateUserData(Map<String, dynamic> userData) async {
    if (userData['url_img_perfil'] == "") {
      userData['url_img_perfil'] = this.url_image;
    }
    this.userData = userData;
    await db.collection('usuarios').document(user.uid).updateData(userData);
  }

  Future<Null> _saveInDatabase(Map<String, dynamic> userData) async {
    if (userData['url_img_perfil'] == "") {
      userData['url_img_perfil'] = this.url_image;
    }
    this.userData = userData;

    await db.collection('usuarios').document(user.uid).setData(this.userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (user == null) user = await _auth.currentUser();

    if (user != null) {
      if (userData['email'] == null) {
        DocumentSnapshot userNow =
            await db.collection('usuarios').document(user.uid).get();
        this.userData = userNow.data;
      }
    }
    notifyListeners();
  }

  Future<Null> _uploadPic(File image) async {
    try {
      var currentImage = await FirebaseStorage.instance
          .ref()
          .child('perfil')
          .child(user.uid)
          .getName();

      if (currentImage != null) {
        FirebaseStorage.instance.ref().child('img_perfil').child(user.uid).delete();
      }

      firebaseStorageRef =
          FirebaseStorage.instance.ref().child('img_perfil').child(user.uid);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
      //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      this.url_image = await (await uploadTask.onComplete).ref.getDownloadURL();
    } catch (e) {
      print(e.message);
    }
  }

  void deleteUser({VoidCallback onSuccess, VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    await _loadCurrentUser();
    user = await _auth.currentUser();
    user.delete().then((_) async {
      await _deleteUserData();
      await _deleteUserStoregeImg();
      signOut();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> _deleteUserData() async {
    await db.collection('usuarios').document(user.uid).delete();
  }

  Future<Null> _deleteUserStoregeImg() async {
    await FirebaseStorage.instance
        .ref()
        .child('perfil')
        .child(user.uid)
        .delete();
  }
}
