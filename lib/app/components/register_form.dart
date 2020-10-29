import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpsp_app/app/components/show_alert_dialog.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/services/user_service.dart';
import 'package:validadores/ValidarEmail.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedCityField = "São Paulo";
  String _password = "";
  bool _agreedToTOS = true;
  UserService userService = new UserService();
  UserModel userModel = new UserModel();
  TextEditingController dateCtl = TextEditingController();

  var cpfMask = new MaskTextInputFormatter(
      mask: '##.###.###.#-##', filter: {"#": RegExp(r'[0-9]')});

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
              return null;
            },
            onSaved: (value) {
              userModel.name = value;
            },
          ),
          DropdownButtonFormField<String>(
            value: selectedCityField,
            decoration: const InputDecoration(
                labelText: 'Município', hintText: 'ex. São Paulo, SP - Brasil'),
            onChanged: (city) {
              selectedCityField = city;
              userModel.location = city;
            },
            validator: (value) =>
                value == null ? 'Município é obrigatória' : null,
            items: [
              "São Paulo",
              "Adamantina",
              "Adolfo",
              "Aguaí",
              "Águas da Prata",
              "Águas de Santa Bárbara",
              "Águas de São Pedro",
              "Ourinhos",
              "Ouro Verde",
              "Agudos",
              "Alambari",
              "Suzano",
              "Osasco",
              "Alfredo Marcondes",
              "São Pedro",
              "São Pedro do Turvo",
              "São Roque",
              "São Sebastião",
              "São Sebastião da Grama",
              "São Simão",
              "São Vicente",
              "Sebastianópolis do Sul",
              "Serra Azul",
              "Serra Negra",
              "Serrana",
              "Sertãozinho",
              "Sete Barras",
              "Vitória Brasil",
              "Votorantim",
              "Votuporanga",
              "Zacarias"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextFormField(
            inputFormatters: [cpfMask],
            decoration: const InputDecoration(
                labelText: 'CPF', hintText: 'ex. 123.456.789-00'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'CPF é obrigatório';
              } else if (!CPF.isValid(value)) {
                return 'CPF inválido';
              }
              return null;
            },
            onSaved: (value) {
              userModel.cpf = value;
            },
          ),
          TextFormField(
            controller: dateCtl,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: "Data de Nascimento",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'A Data de Nascimento é obrigatória.';
              }
              return null;
            },
            onTap: () async {
              DateTime date;
              FocusScope.of(context).requestFocus(new FocusNode());

              DateTime today = DateTime.now();

              date = await showDatePicker(
                  context: context,
                  initialDate: today.subtract(Duration(days: 500)),
                  firstDate: DateTime.utc(1900),
                  lastDate: today.subtract(Duration(days: 500)));

              String dateSlug =
                  "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

              String dateScreen =
                  "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";

              dateCtl.text = dateScreen;
              userModel.birthday = DateTime.parse(dateSlug);
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
              return null;
            },
            onSaved: (value) {
              userModel.phone = value;
            },
          ),
          TextFormField(
            obscureText: false,
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
              userModel.email = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            validator: (String value) {
              _password = value;
              if (value.trim().isEmpty) {
                return 'Senha é obrigatória';
              } else if (value.length < 5) {
                return 'A senha deve ter mais caracteres';
              }
              return null;
            },
            obscureText: true,
            onSaved: (value) {
              userModel.password = value;
            },
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
              return null;
            },
            obscureText: true,
            onSaved: (value) {
              userModel.password = value;
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
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        userService.create(userModel).then((userCreated) {
          SnackBar snackBar = SnackBar(
            content: Text('Cadastro atualizado com sucesso!'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
          Navigator.pop(context);
          showAlertDialog(
              context, "Usuário criado com sucesso", Icon(Icons.check));
          Scaffold.of(context).showSnackBar(snackBar);
        }).catchError((onError) {
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
        });
      }
    } on Exception catch (e, s) {
      print(s);
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
