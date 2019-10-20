import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({Key key, this.userAuth, this.usuario, this.userTipe})
      : super(key: key);
  final FirebaseUser userAuth;
  final DocumentSnapshot usuario;
  final bool userTipe;

  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Pedidos"),
              centerTitle: true,
              bottom: new TabBar(
                tabs: <Widget>[
                  Tab(child: Text("Anteriores")),
                  Tab(child: Text("Em andamento"))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _buildAnteriores(),
                _buildEmAndamento()
              ],
            )));
  }

  Widget _buildAnteriores(){
    return Container();
  }

   Widget _buildEmAndamento(){
    return Container();
  }
}
// Center(
//                 child: Container(
//               padding: EdgeInsets.all(15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(Icons.sentiment_dissatisfied, size: 60),
//                   Divider(
//                     color: Colors.transparent,
//                   ),
//                   Text(
//                       widget.userTipe
//                           ? "Você ainda não realizou nenhum pedido!"
//                           : "Você não está logado, crie uma conta ou faça login para acessar seus pedidos!",
//                       style: TextStyle(fontSize: 20),
//                       textAlign: TextAlign.center),
//                 ],
//               ),
//             ))