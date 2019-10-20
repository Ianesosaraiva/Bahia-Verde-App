import 'package:bahia_verde/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Favoritos extends StatefulWidget {
  @override
  _FavoritosState createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favoritos"),
          centerTitle: true,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Center(
              child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sentiment_dissatisfied, size: 60),
                Divider(
                  color: Colors.transparent,
                ),
                Text(
                    model.isLoggedIn()
                        ? "Você ainda não adicionou nada aos seus favoritos!"
                        : "Você não está logado, crie uma conta ou faça login para acessar seus favoritos!",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ],
            ),
          ));
        }));
  }
}
