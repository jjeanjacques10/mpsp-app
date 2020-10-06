import 'package:flutter/material.dart';
import 'package:validadores/ValidarEmail.dart';
import 'package:cpfcnpj/cpfcnpj.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = "";
  bool _agreedToTOS = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nome',
              hintText: 'ex. Maria Paula da Silva Pereira',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Nome é obrigatório';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Localização ',
                hintText: 'ex. São Paulo, SP - Brasil'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Localização é obrigatória';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'CPF', hintText: 'ex. 123.456.789-00'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'CPF é obrigatório';
              }else if(!CPF.isValid(value)){
                return 'CPF inválido';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Telefone',
              hintText: 'ex. (11) 98765-4321',
            ),
            validator: (String value) {
              final pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
              final regExp = RegExp(pattern);

              if (value.trim().isEmpty) {
                return 'Telefone é obrigatório';
              } else if (!regExp.hasMatch(value.trim())) {
                return 'Telefone inválido';
              }
            },
          ),
          /* TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'ex. maria.paula@mpsp.br'
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email é obrigatório';
              }else if(!value.trim().contains('@')){
                return 'Insira um e-mail válido';
              }
            },
          ), */
          TextFormField(
            obscureText: false,
            //style: style,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'ex. maria.paula@mpsp.br'
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'O campo Email é obrigatório.';
              } else if (value.length < 12) {
                return 'O e-mail deve ter mais caracteres';
              } else if (!EmailValidator.validate(value)) {
                return 'O formato do e-mail está errado';
              }
              return null;
            },
            onSaved: (value) {
              //userModel.email = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Senha é obrigatória';
              }
            },
            obscureText: true,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Confirmar senha',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Confirmar senha é obrigatório';
              } else if (value.trim() != _password.trim()) {
                return 'As senhas devem ser iguais';
              }
            },
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'Eu concordo com os Termos de Serviço \n'
                    'e Política de Privacidade',
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: OutlineButton(
              highlightedBorderColor: Colors.black,
              onPressed: _submittable() ? _submit : null,
              child: const Text('Cadastrar'),
            ),
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      const SnackBar snackBar = SnackBar(content: Text('Form submitted'));

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
