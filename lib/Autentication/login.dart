import 'package:bahia_verde/Autentication/recover_password.dart';
import 'package:bahia_verde/home.dart';
import 'package:bahia_verde/Autentication/register.dart';
import 'package:bahia_verde/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

var usuario;
final db = Firestore.instance;

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(163),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;
    final primaryColor = Theme.of(context).primaryColor;
    final hintColor = Theme.of(context).hintColor;

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
        backgroundColor: primaryColor,
        resizeToAvoidBottomPadding: true,
        key: _scaffoldKey,
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoggedIn()) return Home();

            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Stack(fit: StackFit.expand, children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0, right: 28.0, top: 50.0),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "img/logo_circle.png",
                                      width: ScreenUtil.getInstance()
                                          .setWidth(150),
                                      height: ScreenUtil.getInstance()
                                          .setHeight(150),
                                    ),
                                    Text("",
                                        style: TextStyle(
                                            fontFamily: "Poppins-Bold",
                                            fontSize: ScreenUtil.getInstance()
                                                .setSp(46),
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
                                height: ScreenUtil.getInstance().setHeight(680),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Login",
                                          style: TextStyle(
                                              color: accentColor,
                                              fontSize: ScreenUtil.getInstance()
                                                  .setSp(45),
                                              fontFamily: "Poppins-Bold",
                                              letterSpacing: .6)),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(30),
                                      ),
                                      TextFormField(
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return "Por favor, insira seu email";
                                          }
                                        },
                                        controller: _emailController,
                                        cursorColor: accentColor,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(color: accentColor),
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: hintColor)),
                                            labelText: "Email",
                                            focusColor: accentColor,
                                            labelStyle: TextStyle(
                                                color: accentColor,
                                                fontFamily: "Poppins-Medium")),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(30),
                                      ),
                                      TextFormField(
                                        validator: (input) {
                                          if (input.length < 6) {
                                            return "Por favor, insira senha acima de 6 caracteres";
                                          }
                                        },
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: hintColor)),
                                            labelText: "Senha",
                                            labelStyle: TextStyle(
                                                color: accentColor,
                                                fontFamily: "Poppins-Medium")),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(35),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          GestureDetector(
                                              child: Text(
                                                "Esqueceu a senha?",
                                                style: TextStyle(
                                                    color: accentColor,
                                                    fontFamily:
                                                        "Poppins-Medium",
                                                    fontSize:
                                                        ScreenUtil.getInstance()
                                                            .setSp(28)),
                                              ),
                                              onTap: () {
                                                //model.signOut();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RecoverdPassword()));
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            child: Container(
                                              width: ScreenUtil.getInstance()
                                                  .setWidth(300),
                                              height: ScreenUtil.getInstance()
                                                  .setHeight(80),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        accentColor,
                                                        Colors.red[500]
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color(0xFF6078ea)
                                                            .withOpacity(.3),
                                                        offset:
                                                            Offset(0.0, 8.0),
                                                        blurRadius: 10.0)
                                                  ]),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      model.signIn(
                                                          email:
                                                              _emailController
                                                                  .text,
                                                          password:
                                                              _passwordController
                                                                  .text,
                                                          onSuccess: onSuccess,
                                                          onFail: onFail);
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Text("Entrar",
                                                        style: TextStyle(
                                                            color: primaryColor,
                                                            fontFamily:
                                                                "Poppins-Bold",
                                                            fontSize: 18,
                                                            letterSpacing:
                                                                1.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(35)),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     horizontalLine(),
                              //     Text("Social Login",
                              //         style: TextStyle(
                              //             fontSize: 16.0,
                              //             fontFamily: "Poppins-Medium")),
                              //     horizontalLine()
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: ScreenUtil.getInstance().setHeight(20),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF6078ea)
                                                  .withOpacity(.3),
                                              offset: Offset(0.0, 8.0),
                                              blurRadius: 8.0)
                                        ],
                                        borderRadius: BorderRadius.circular(100),
                                        gradient: LinearGradient(colors: [
                                          Colors.red[900],
                                          Colors.red[700],
                                          Colors.red[400]
                                        ])),
                                    child: RawMaterialButton(
                                      padding: EdgeInsets.all(10),
                                      onPressed: () {
                                        model.signInWithGoogle(
                                            onFail: onFail,
                                            onSuccess: onSuccess);
                                      },
                                      child: Text(
                                        "Entre com o Google",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register()));
                                    },
                                    child: Text("Cadastre-se  |  ",
                                        style: TextStyle(
                                            color: accentColor,
                                            fontFamily: "Poppins-Bold")),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    },
                                    child: Text("Visitante",
                                        style: TextStyle(
                                            color: accentColor,
                                            fontFamily: "Poppins-Bold")),
                                  )
                                ],
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

  void onSuccess() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha no Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
