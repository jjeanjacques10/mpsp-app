import 'package:flutter/material.dart';
import 'package:mpsp_app/components/contact_channels.dart';

import '../components/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  static const String routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: ContactChannels(),
      body:
          //IconData(59558, fontFamily: 'MaterialIcons'),
          const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
