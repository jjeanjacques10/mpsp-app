import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mpsp_app/app/components/showAlertDialog.dart';
import 'package:mpsp_app/app/model/User.dart';
import 'package:mpsp_app/app/services/user_repository.dart';
import 'package:mpsp_app/app/utils/app_theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserRepository repository = new UserRepository();
  UserModel userModel = new UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 150,
                    ),
                    SizedBox(width: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Senha é obrigatória';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userModel.password = value;
                      },
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
                              repository
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
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Google,
                      text: "Login com Google",
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.FacebookNew,
                      text: "Login com Facebook",
                      onPressed: () {},
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
