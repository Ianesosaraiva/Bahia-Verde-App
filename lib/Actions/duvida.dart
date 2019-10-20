
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';

class Duvida extends StatefulWidget {
  @override
  DuvidaState createState() => DuvidaState();
}

class DuvidaState extends State<Duvida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dúvidas"),
        centerTitle: true,
    ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child:Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text( "Dúvidas frequentes",
              style: TextStyle(
                fontFamily: androidAdaptiveBackgroundFileName,
                fontSize: 20.0,
              )),
             ),
            ),
          ], 
        ),
     ),
    );
  }
}