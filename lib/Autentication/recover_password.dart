import 'package:bahia_verde/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login.dart';

class RecoverdPassword extends StatefulWidget {
  @override
  _RecoverdPasswordState createState() => _RecoverdPasswordState();
}

class _RecoverdPasswordState extends State<RecoverdPassword> {
  @override
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;
    final primaryColor = Theme.of(context).primaryColor;
    final hintColor = Theme.of(context).hintColor;

    return Scaffold(
        key: _scaffoldKey,
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return Stack(fit: StackFit.expand, children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image.asset("img/design2.png"),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Center(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.all(15.0),
                      child: Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 28.0, right: 28.0, top: 0.0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "img/logo_circle.png",
                                  width: ScreenUtil.getInstance().setWidth(150),
                                  height:
                                      ScreenUtil.getInstance().setHeight(150),
                                ),
                                Text("",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Bold",
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(46),
                                        letterSpacing: .6,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(100),
                          ),
                          Container(
                            width: double.infinity,
                            height: ScreenUtil.getInstance().setHeight(500),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, 15.0),
                                      blurRadius: 15.0),
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, -10.0),
                                      blurRadius: 10.0),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Recuperar Senha",
                                      style: TextStyle(
                                          color: accentColor,
                                          fontSize: ScreenUtil.getInstance()
                                              .setSp(45),
                                          fontFamily: "Poppins-Bold",
                                          letterSpacing: .6)),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return "Por favor, insira seu email";
                                      }
                                    },
                                    controller: _emailController,
                                    cursorColor: accentColor,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: hintColor)),
                                        labelText: "Email",
                                        focusColor: accentColor,
                                        labelStyle: TextStyle(
                                            color: accentColor,
                                            fontFamily: "Poppins-Medium")),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(35),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(20),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          width: ScreenUtil.getInstance()
                                              .setWidth(300),
                                          height: ScreenUtil.getInstance()
                                              .setHeight(80),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                accentColor,
                                                Colors.red[500]
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0xFF6078ea)
                                                        .withOpacity(.3),
                                                    offset: Offset(0.0, 8.0),
                                                    blurRadius: 10.0)
                                              ]),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                if (_emailController
                                                    .text.isEmpty) {
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Por favor, coloque um email!"),
                                                    backgroundColor:
                                                        accentColor,
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ));
                                                } else {
                                                  model.recoverPassword(
                                                      _emailController.text);

                                                  _scaffoldKey.currentState
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Verifique seu email!"),
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ));
                                                }
                                              },
                                              child: Center(
                                                child: Text("Recuperar",
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontFamily:
                                                            "Poppins-Bold",
                                                        fontSize: 18,
                                                        letterSpacing: 1.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    "Já tem sua senha? Login",
                                                    style: TextStyle(
                                                        color: accentColor,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            }),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                        ],
                      )))),
            ]);
          },
        ));
  }
}
