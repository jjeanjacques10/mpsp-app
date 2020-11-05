import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/services/user_service.dart';
import 'package:validadores/ValidarCPF.dart';
import 'package:validadores/ValidarEmail.dart';

// ignore: must_be_immutable
class ProfileForm extends StatefulWidget {
  ProfileForm({Key key, this.userModel}) : super(key: key);

  UserModel userModel;

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

var cpfMask = new MaskTextInputFormatter(
    mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedCityField = "São Paulo";
  bool _agreedToTOS = true;
  UserService userService = new UserService();
  TextEditingController dateCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dateBirthday = '10/10/1999';
    if (widget.userModel.birthday != null) {
      dateBirthday =
          "${widget.userModel.birthday.day.toString().padLeft(2, '0')}/${widget.userModel.birthday.month.toString().padLeft(2, '0')}/${widget.userModel.birthday.year.toString()}";
    }
    dateCtl.text = dateBirthday;
    selectedCityField =
        (widget.userModel.location != null && widget.userModel.location != "")
            ? widget.userModel.location
            : "São Paulo";
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: widget.userModel.image != null
                  ? NetworkImage(widget.userModel.image.replaceAll(' ', ''))
                  : AssetImage("assets/images/avatar.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
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
              return null;
            },
            onSaved: (value) {
              widget.userModel.name = value;
            },
          ),
          DropdownButtonFormField<String>(
            value: selectedCityField,
            decoration: const InputDecoration(
                labelText: 'Município ',
                hintText: 'ex. São Paulo, SP - Brasil'),
            onChanged: (city) {
              selectedCityField = city;
              widget.userModel.location = city;
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
          widget.userModel.cpf == "" || widget.userModel.cpf == null
              ? TextFormField(
                  inputFormatters: [cpfMask],
                  initialValue: widget.userModel.cpf,
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
                    widget.userModel.cpf = value;
                  },
                )
              : TextFormField(
                  initialValue: widget.userModel.cpf,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'CPF', hintText: 'ex. 123.456.789-00'),
                  onSaved: (value) {
                    widget.userModel.cpf = value;
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
              widget.userModel.birthday = DateTime.parse(dateSlug);
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
              return null;
            },
            onSaved: (value) {
              widget.userModel.phone = value;
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
              widget.userModel.email = value;
            },
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
        _formKey.currentState.save();
        userService.update(widget.userModel).then((userCreated) {
          SnackBar snackBar = SnackBar(
            content: Text('Cadastro atualizado com sucesso!'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                Navigator.pop(context, 'update');
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }).catchError((onError) {
          print(onError);
          SnackBar snackBar = SnackBar(
            content: Text('Não foi possível atualizar'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                Navigator.pop(context, 'update');
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
}
