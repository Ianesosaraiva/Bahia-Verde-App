import 'package:bahia_verde/data/data_cart_pedidos.dart';
import 'package:bahia_verde/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  final db = Firestore.instance;
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);
  bool isLoading = false;

  List<CartProduct> products = [];

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItens();
    }
  }

  void addCartItem(CartProduct cartProduct) async {
    DocumentSnapshot doc = await db
        .collection('usuarios')
        .document(user.user.uid)
        .collection('pedidos')
        .document(cartProduct.pid)
        .get();

    if (doc.data == null) {
      products.add(cartProduct);
      db
          .collection('usuarios')
          .document(user.user.uid)
          .collection('pedidos')
          .add(cartProduct.toMap())
          .then((doc) {
        cartProduct.cid = doc.documentID;
      });
    } else {
      if (doc.data['tipo'] != cartProduct.tipo) {
        products.add(cartProduct);
        db
            .collection('usuarios')
            .document(user.user.uid)
            .collection('pedidos')
            .add(cartProduct.toMap())
            .then((doc) {
          cartProduct.cid = doc.documentID;
        });
      } else {
        addCartItem(cartProduct);
      }
    }

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    db
        .collection('usuarios')
        .document(user.user.uid)
        .collection('pedidos')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void addProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    db
        .collection('usuarios')
        .document(user.user.uid)
        .collection('pedidos')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItens() async {
    QuerySnapshot query = await db
        .collection('usuarios')
        .document(user.user.uid)
        .collection('pedidos')
        .getDocuments();
    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    db
        .collection('usuarios')
        .document(user.user.uid)
        .collection('pedidos')
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }
}
