import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validadores/ValidarEmail.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mpsp_app/app/components/show_alert_dialog.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/services/user_service.dart';
import 'package:mpsp_app/app/utils/app_theme.dart';
import 'package:splashscreen/splashscreen.dart';

class FlashScreen extends StatefulWidget {
  @override
  FlashScreenState createState() => new FlashScreenState();
}

class FlashScreenState extends State<FlashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new LoginScreen(),
        /* title: new Text(
          'Bem vindo ao MPSP Digital',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ), */
        image: new Image.asset('assets/images/mpsp-digital-logo-branco.png'),
        backgroundColor: Color.fromRGBO(197, 23, 24, 1),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.white);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserService userService = new UserService();
  UserModel userModel = new UserModel();

  @override
  void initState() {
    userService.isLogged().then((isLogged) {
      if (isLogged == true) {
        Navigator.pushReplacementNamed(
          context,
          "/home",
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/images/mpsp-logo.png'),
                      height: 100,
                    ),
                    SizedBox(width: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'ex. maria.paula@mpsp.br'),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Email é obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userModel.email = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'O campo senha é obrigatório.';
                        } else if (value.length < 5) {
                          return 'A senha deve ter mais caracteres';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userModel.password = value;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          color: MPSPAppTheme.grey,
                          child: Text(
                            "Cadastrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/register",
                            );
                          },
                        ),
                        SizedBox(width: 15),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          color: MPSPAppTheme.red,
                          child: Text(
                            "Entrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              userService
                                  .login(userModel.email, userModel.password)
                                  .then((value) {
                                if (value == true) {
                                  print("Login Realizado");
                                  Navigator.pushReplacementNamed(
                                    context,
                                    "/home",
                                  );
                                } else {
                                  print("Login Não Realizado");
                                  showAlertDialog(
                                      context,
                                      "Não foi possivel realizar o login",
                                      Icon(Icons.error));
                                }
                              }).catchError((onError) => {
                                        showAlertDialog(
                                            context,
                                            "Não foi possivel realizar o login",
                                            Icon(Icons.error))
                                      });
                            } else {
                              showAlertDialog(
                                  context,
                                  "Não foi possivel realizar o login",
                                  Icon(Icons.error));
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    FlatButton(
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Esqueci minha senha');
                      },
                    ),
                    SignInButton(
                      Buttons.Google,
                      text: "Login com Google",
                      onPressed: () {
                        print("Login com Google");
                      },
                    ),
                    SignInButton(
                      Buttons.FacebookNew,
                      text: "Login com Facebook",
                      onPressed: () {
                        print("Login com Facebook");
                      },
                    ),
                    SizedBox(width: 150),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
