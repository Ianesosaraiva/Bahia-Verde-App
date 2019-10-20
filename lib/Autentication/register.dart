import 'dart:io';
import 'package:bahia_verde/Autentication/login.dart';
import 'package:bahia_verde/home.dart';
import 'package:bahia_verde/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

final db = Firestore.instance;

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
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
        key: _scaffoldKey,
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 28.0, right: 28.0, top: 60.0),
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
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       left: 115.0, right: 28.0, top: 50.0, bottom: 0),
                          //   child: Row(
                          //     children: <Widget>[
                          //       Text("Cadastro",
                          //           style: TextStyle(
                          //             color: Colors.green[900],
                          //               fontFamily: "Poppins-Bold",
                          //               fontSize:
                          //                   ScreenUtil.getInstance().setSp(46),
                          //               letterSpacing: .6,
                          //               fontWeight: FontWeight.bold))
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(120),
                          ),
                          Container(
                              width: double.infinity,
                              height: ScreenUtil.getInstance().setHeight(1500),
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
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Text("Cadastro",
                                      //     style: TextStyle(
                                      //         color: Colors.green[900],
                                      //         fontFamily: "Poppins-Bold",
                                      //         fontSize: ScreenUtil.getInstance().setSp(46),
                                      //         letterSpacing: .6,
                                      //         fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(30),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                gradient: LinearGradient(
                                                    colors: [
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
                                                "Cadastre-se com o Google",
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(40),
                                      ),
                                      GestureDetector(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                              radius: 50,
                                              backgroundColor: primaryColor,
                                              backgroundImage: (_image != null)
                                                  ? FileImage(_image)
                                                  : AssetImage(
                                                      'img/perfil_auto.png')),
                                        ),
                                        onTap: () {
                                          getImage();
                                        },
                                      ),
                                      TextFormField(
                                        controller: _nameController,
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return "Por favor, insira seu nome";
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: hintColor)),
                                          labelText: "Nome",
                                        ),
                                        style: TextStyle(
                                            color: accentColor, fontSize: 15.0),
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      TextFormField(
                                        controller: _emailController,
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return "Por favor, insira um email";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: hintColor)),
                                          labelText: "Email",
                                        ),
                                        style: TextStyle(
                                            color: accentColor, fontSize: 15.0),
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      TextFormField(
                                        controller: _telefoneController,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: hintColor)),
                                          labelText: "Telefone",
                                        ),
                                        style: TextStyle(
                                            color: accentColor, fontSize: 15.0),
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      // TextFormField(
                                      //   controller: _enderecoController,
                                      //   validator: (input) {
                                      //     if (input.isEmpty) {
                                      //       return "Por favor, insira seu Endereço";
                                      //     }
                                      //   },
                                      //   decoration: InputDecoration(
                                      //  focusedBorder: UnderlineInputBorder(
                                      //          borderSide: BorderSide(
                                      //              color: Colors.green)),
                                      //     labelText: "Endereço",
                                      //   ),
                                      //   style: TextStyle(
                                      //       color: Colors.green,
                                      //       fontSize: 15.0),
                                      // ),
                                      //Divider(
                                      //color: Colors.transparent,
                                      //),
                                      TextFormField(
                                        controller: _passwordController,
                                        validator: (input) {
                                          if (input.length < 6) {
                                            return "Por favor, insira senha acima de 6 caracteres";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: hintColor)),
                                          labelText: "Senha",
                                        ),
                                        obscureText: true,
                                        style: TextStyle(
                                            color: accentColor, fontSize: 15.0),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(40),
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
                                                      Map<String, dynamic>
                                                          userData = {
                                                        'nome': _nameController
                                                            .text,
                                                        "email":
                                                            _emailController
                                                                .text,
                                                        'telefone':
                                                            _telefoneController
                                                                .text,
                                                        'endereco':
                                                            _enderecoController
                                                                .text,
                                                        'url_img_perfil': ""
                                                      };
                                                      model.signUp(
                                                          userData: userData,
                                                          password:
                                                              _passwordController
                                                                  .text,
                                                          onFail: onFail,
                                                          onSuccess: onSuccess,
                                                          image: _image);
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Text("Salvar",
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
                                      SizedBox(
                                        height: ScreenUtil.getInstance()
                                            .setHeight(20),
                                      ),
                                      GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Já tem uma conta? Login",
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
                              ))
                        ],
                      )),
                ),
              ),
            ]);
          },
        ));
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print("Images $_image");
    });
  }

  void onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuario cadastrado com sucesso!"),
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
      content: Text("Falha no cadastro!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
