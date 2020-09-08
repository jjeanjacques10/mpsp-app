import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Nome é obrigatório';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Localização ',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Localização é obrigatória';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'CPF',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'CPF é obrigatório';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Telefone',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Telefone é obrigatório';
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email é obrigatório';
              }
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
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Confirmar  senha',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Confirmar senha é obrigatório';
              }
            },
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
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Cadastrar'),
              ),
            ],
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
