import 'dart:io';

import 'package:bahia_verde/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class EditarUsuario extends StatefulWidget {
  const EditarUsuario({Key key}) : super(key: key);

  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _telefoneController = TextEditingController();
  var _enderecoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Editar Usuario"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            _nameController =
                TextEditingController(text: model.userData['nome']);
            _emailController =
                TextEditingController(text: model.userData['email']);
            _telefoneController =
                TextEditingController(text: model.userData['telefone']);
            _enderecoController =
                TextEditingController(text: model.userData['endereco']);

            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          GestureDetector(
                            child: Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  backgroundImage: (model
                                              .userData['url_img_perfil'] !=
                                          null)
                                      ? _image != null
                                          ? FileImage(_image)
                                          : NetworkImage(
                                              model.userData['url_img_perfil'])
                                      : _image != null
                                          ? FileImage(_image)
                                          : AssetImage('img/perfil_auto.png')),
                            ),
                            onTap: () {
                              getImage();
                            },
                          ),
                          TextFormField(
                            initialValue: _nameController.text,
                            onSaved: (value) {
                              _nameController.text = value;
                            },
                            validator: (input) {
                              if (input.isEmpty) {
                                return "Por favor, insira seu nome";
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).hintColor,)),
                              labelText: "Nome",
                            ),
                            style:
                                TextStyle(color: Theme.of(context).accentColor, fontSize: 17.0),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          TextFormField(
                            initialValue: _emailController.text,
                            //controller: _emailController,
                            onSaved: (value) {
                              _emailController.text = value;
                            },
                            validator: (input) {
                              if (input.isEmpty) {
                                return "Por favor, insira um email";
                              }
                            },
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Theme.of(context).hintColor,)),
                                labelText: "Email"),
                            style:
                                TextStyle(color: Theme.of(context).accentColor, fontSize: 17.0),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _telefoneController.text = value;
                            },
                            initialValue: (_telefoneController.text != null)
                                ? _telefoneController.text
                                : "",
                            //controller: _telefoneController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).hintColor)),
                              labelText: "Telefone",
                            ),
                            style:
                                TextStyle(color: Theme.of(context).accentColor, fontSize: 17.0),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          TextFormField(
                            //controller: _enderecoController,
                            onSaved: (value) {
                              _enderecoController.text = value;
                            },
                            initialValue: (_enderecoController.text != null)
                                ? _enderecoController.text
                                : "",
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).hintColor)),
                              labelText: "Endereço",
                            ),
                            style:
                                TextStyle(color: Theme.of(context).accentColor, fontSize: 17.0),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          GestureDetector(
                              child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Container(
                                    height: 50.0,
                                    child: RaisedButton(
                                        onPressed: () {
                                          final formState =
                                              _formKey.currentState;
                                          if (formState.validate()) {
                                            formState.save();
                                            Map<String, dynamic> userData = {
                                              'nome': _nameController.text,
                                              "email": _emailController.text,
                                              'telefone':
                                                  _telefoneController.text,
                                              'endereco':
                                                  _enderecoController.text,
                                              'url_img_perfil': ""
                                            };
                                            model.updateUser(
                                                userData: userData,
                                                image: _image,
                                                onFail: onFail,
                                                onSuccess: onSuccess);
                                          }
                                        },
                                        child: Text(
                                          "Editar",
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: 20.0),
                                        ),
                                        color: Theme.of(context).accentColor),
                                  ))),
                          Divider(
                            color: Colors.transparent,
                          ),
                        ],
                      ))),
            );
          },
        ));
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print("Images $_image");
    });
  }

  void onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuario editado com sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    // Future.delayed(Duration(seconds: 2)).then((_) {
    //   Navigator.of(context).pop();
    // });
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha na edição!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
