import 'package:bahia_verde/model/auth_model.dart';
import 'package:bahia_verde/model/cart_model.dart';
import 'package:bahia_verde/tile/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meu Carrinho"),
          centerTitle: true,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 8.0),
              alignment: Alignment.center,
              child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
                  int p = model.products.length;
                  return Text(
                    "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                    style: TextStyle(
                        fontSize: 17.0, color: Theme.of(context).primaryColor),
                  );
                },
              ),
            )
          ],
        ),
        body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            if (model.isLoading && UserModel.of(context).isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!UserModel.of(context).isLoggedIn()) {
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
                        "Você não está logado, crie uma conta ou faça login para acessar seu carrinho!",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                  ],
                ),
              ));
            } else if (model.products == null || model.products.length == 0) {
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
                    Text("Você ainda não realizou nenhum pedido!",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                  ],
                ),
              ));
            } else {
              return ListView(
                children: <Widget>[
                  Column(
                      children: model.products.map((product) {
                    return CartTile(product);
                  }).toList())
                ],
              );
            }
          },
        ));
  }
}
