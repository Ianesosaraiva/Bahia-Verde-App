import 'package:bahia_verde/Autentication/login.dart';
import 'package:bahia_verde/model/auth_model.dart';
import 'package:bahia_verde/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
                model: CartModel(model),
                child: new MaterialApp(
                    title: "Bahia Verde App",
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        hintColor: Colors.grey,
                        accentColor: Colors.red[900],
                        primaryColor: Colors.white,
                        primarySwatch: Colors.red,
                        inputDecorationTheme: InputDecorationTheme(
                            focusColor: Colors.red[900],
                            prefixStyle: TextStyle(color: Colors.red[900]),
                            labelStyle: TextStyle(color: Colors.red[900])),
                        textTheme: TextTheme(
                            title: TextStyle(color: Colors.white),
                            subtitle: TextStyle(color: Colors.white)),

                        //iconTheme: IconThemeData(color: Colors.white),
                        floatingActionButtonTheme:
                            FloatingActionButtonThemeData(
                                hoverColor: Colors.redAccent),
                        tabBarTheme: TabBarTheme(labelColor: Colors.white),
                        appBarTheme: AppBarTheme(
                            color: Colors.red[900],
                            textTheme: TextTheme(
                                title: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            iconTheme: IconThemeData(color: Colors.white))),
                    home: Login()));
          },
        ));
  }
}
