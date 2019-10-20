import 'package:bahia_verde/Actions/carrinho.dart';
import 'package:bahia_verde/Actions/configuracoes.dart';
import 'package:bahia_verde/Actions/favoritos.dart';
import 'package:bahia_verde/Actions/pedidos.dart';
import 'package:bahia_verde/Actions/sobre.dart';
import 'package:bahia_verde/Actions/duvida.dart';
import 'package:bahia_verde/Autentication/login.dart';
import 'package:bahia_verde/CRUD/edit_users.dart';
import 'package:bahia_verde/carousel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/auth_model.dart';

QuerySnapshot produtos;
DocumentSnapshot produto;
final db = Firestore.instance;
String id;

class Home extends StatefulWidget {
  static Iterable get all => null;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    //buildImagesFirebase();
  }
  String title;

  int _selectedPage = 0;

  final _appBarTitle = [
    Text("Home", style: TextStyle(color: Colors.white)),
    Text("Historico", style: TextStyle(color: Colors.white)),
    Text("Perfil", style: TextStyle(color: Colors.white))
  ];
// SliverAppBar(
//               backgroundColor: Colors.transparent,
//               floating: true,
//               title: Text("Home"),
//               centerTitle: true,
//             ),
  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: accentColor,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                "Historico",
                style: TextStyle(color: Theme.of(context).hintColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Perfil")),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    if (_selectedPage == 0) {
      return AppBar(
        title: _appBarTitle[_selectedPage],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          )
        ],
      );
    } else if (_selectedPage == 1) {
      return AppBar(title: _appBarTitle[_selectedPage], centerTitle: true);
    } else {
      return AppBar(
          title: _appBarTitle[_selectedPage],
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditarUsuario()));
              },
            )
          ]);
    }
  }

  Widget _buildBody() {
    if (_selectedPage == 0) {
      //Home
      return CarouselScreen();
    } else if (_selectedPage == 1) {
      //Pedidos
      return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Container(
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
                      ? "Você ainda não possui nenhum historico!"
                      : "Você não está logado, crie uma conta ou faça login para acessar seus historico!",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
            ],
          ),
        );
      });
    } else {
      //Perfil
      return SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              return Column(
                children: <Widget>[
                  model.isLoggedIn()
                      ? Text("")
                      : Icon(Icons.sentiment_dissatisfied, size: 60),
                  Divider(
                    color: Colors.transparent,
                  ),
                  (model.isLoggedIn())
                      ? _buildUserPerfil()
                      : Text(
                          "Você não está logado, crie uma conta ou faça login para acessar seu perfil!",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center),
                ],
              );
            },
          ));
    }
  }

  Widget _buildFloatingActionButton() {
    if (_selectedPage == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Carrinho()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.shopping_cart, color: Colors.white),
      );
    } else {
      return null;
    }
  }

  Widget _buildDrawer() {
    if (_selectedPage == 0) {
      return Drawer(
        child: new Column(
          children: <Widget>[
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                return new UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).accentColor),
                  accountName: new Text(
                      "Olá, ${model.isLoggedIn() ? model.userData['nome'] : ""}",
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0)),
                  accountEmail: Row(children: <Widget>[
                    InkResponse(
                      child: Text(
                          model.isLoggedIn()
                              ? model.userData['email']
                              : "Entre ou cadastre-se >",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        model.isLoggedIn()
                            ? null
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                      },
                    ),
                    InkResponse(
                      child: Text(
                        model.isLoggedIn() ? "\t\t\tSair" : "",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                        model.isLoggedIn() ? model.signOut() : null;
                        model.isLoggedIn()
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()))
                            : null;
                      },
                    ),
                  ]),
                  currentAccountPicture: new CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: model.isLoggedIn() &&
                              model.userData['url_img_perfil'] != null
                          ? NetworkImage(model.userData['url_img_perfil'])
                          : AssetImage('img/perfil_auto.png')),
                );
              },
            ),
            ListTile(
                title: Text("Pedidos",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading: Icon(Icons.list, color: Theme.of(context).accentColor),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pedidos()));
                }),
            ListTile(
                title: Text("Favoritos",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading: Icon(Icons.star, color: Theme.of(context).accentColor),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Favoritos()));
                }),
            ListTile(
                title: Text("Configurações",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading:
                    Icon(Icons.settings, color: Theme.of(context).accentColor),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Configuracoes()));
                }),
            ListTile(
                title: Text("Dúvidas",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading:
                    Icon(Icons.textsms, color: Theme.of(context).accentColor),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Duvida()));
                }),
            new Divider(),
            ListTile(
                title: Text("Sobre",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                leading: Icon(Icons.info, color: Theme.of(context).accentColor),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sobre()));
                }),
          ],
        ),
      );
    } else {
      return null;
    }
  }

  Widget _buildUserPerfil() {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Center(
            child: Column(
          children: <Widget>[
            Align(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: model.userData['url_img_perfil'] != null
                    ? NetworkImage(model.userData['url_img_perfil'])
                    : AssetImage('img/perfil_auto.png'),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Text("Nome", style: TextStyle(fontSize: 20)),
                    Text(
                      model.userData['nome'],
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text("Email", style: TextStyle(fontSize: 20)),
                  Text(model.userData['email'],
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text("Endereço", style: TextStyle(fontSize: 20)),
                  Text(
                      model.userData['endereco'] != null
                          ? model.userData['endereco']
                          : "",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Telefone",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                      model.userData['telefone'] != null
                          ? model.userData['telefone']
                          : "",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20)),
                ],
              ),
            ),
          ],
        ));
      },
    );
  }
}
