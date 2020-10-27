import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:validadores/ValidarEmail.dart';

// ignore: must_be_immutable
class ProfileForm extends StatefulWidget {
  ProfileForm({Key key, this.userModel}) : super(key: key);

  UserModel userModel;

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
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
            initialValue: widget.userModel.name,
            decoration: const InputDecoration(
              labelText: 'Nome',
              hintText: 'ex. Maria Paula da Silva Pereira',
            ),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Nome é obrigatório';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Localização ',
                hintText: 'ex. São Paulo, SP - Brasil'),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Localização é obrigatória';
              }
            },
          ),
          TextFormField(
            initialValue: widget.userModel.cpf,
            readOnly: true,
            decoration: const InputDecoration(
                labelText: 'CPF', hintText: 'ex. 123.456.789-00'),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'CPF é obrigatório';
              } else if (!CPF.isValid(value)) {
                return 'CPF inválido';
              }
            },
          ),
          TextFormField(
            initialValue: widget.userModel.phone,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              hintText: 'ex. (11) 98765-4321',
            ),
            validator: (value) {
              final pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
              final regExp = RegExp(pattern);

              if (value.trim().isEmpty) {
                return 'Telefone é obrigatório';
              } else if (!regExp.hasMatch(value.trim())) {
                return 'Telefone inválido';
              }
            },
          ),
          TextFormField(
            initialValue: widget.userModel.email,
            obscureText: false,
            //style: style,
            decoration: const InputDecoration(
                labelText: 'Email', hintText: 'ex. maria.paula@mpsp.br'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return ' Email é obrigatório.';
              } else if (value.length < 12) {
                return 'O email no mínimo 12 caracteres';
              } else if (!EmailValidator.validate(value)) {
                return 'O formato do e-mail está incorreto';
              }
              return null;
            },
            onSaved: (value) {
              //userModel.email = value;
            },
          ),
          TextFormField(
            initialValue: widget.userModel.password,
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            validator: (String value) {
              _password = value;
              if (value.trim().isEmpty) {
                return 'Senha é obrigatória';
              }
            },
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Atualizar'),
              ),
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
    try {
      if (_formKey.currentState.validate()) {
        SnackBar snackBar = SnackBar(
          content: Text('Cadastro atualizado com sucesso!'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } on Exception catch (e, s) {
      print(s);
    }
  }
}
