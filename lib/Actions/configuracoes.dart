import 'dart:io';
import 'package:bahia_verde/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../home.dart';
import 'duvida.dart';
import 'favoritos.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Configurações"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Container(
            //padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: GestureDetector(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Theme.of(context).primaryColor,
                          backgroundImage:
                              (model.userData['url_img_perfil'] != null)
                                  ? _image != null
                                      ? FileImage(_image)
                                      : NetworkImage(
                                          model.userData['url_img_perfil'])
                                  : _image != null
                                      ? FileImage(_image)
                                      : AssetImage('img/perfil_auto.png')),
                    ),
                  ),
                ),
                ListTile(
                    title: Text("Excluir conta",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    leading: Icon(Icons.delete,
                        color: Theme.of(context).accentColor),
                    onTap: () {
                      model.deleteUser(onFail: onFail, onSuccess: onSuccess);
                    }),
                ListTile(
                    title: Text("Notificações",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    leading: Icon(Icons.notifications,
                        color: Theme.of(context).accentColor),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Favoritos()));
                    }),
                ListTile(
                    title: Text("Favoritos",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    leading: Icon(Icons.star,
                        color: Theme.of(context).accentColor),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuracoes()));
                    }),
                ListTile(
                    title: Text("Convidar Amigo",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    leading: Icon(Icons.people,
                        color: Theme.of(context).accentColor),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Duvida()));
                    }),
                new Divider(),
                ListTile(
                    title: Text("Ajuda",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    leading:
                        Icon(Icons.help, color: Theme.of(context).accentColor),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Duvida()));
                    }),
                ListTile(
                    title: Text("Suporte",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    leading:
                        Icon(Icons.call, color: Theme.of(context).accentColor),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Duvida()));
                    }),
                    ListTile(
                      title: Text('ianesoares@gmail.com\norlando.melo.ti@gmail.com'),
                    )
              ],
            ),
          );
        },
      ),
    );
  }

  void onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Conta deletada com sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao excluir conta!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
