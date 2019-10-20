import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  @override
  SobreState createState() => SobreState();
}

class SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
        centerTitle: true,
      ),
      body:Container(
        child: ListView(
          children: <Widget>[
            Text("Aqui testando!")
          ],
        ),
      ),
    );
  }
}