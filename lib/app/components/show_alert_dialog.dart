import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String texto, Icon icone) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: icone,
    content: Text(texto),
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(ctx).pop(true);
        Navigator.of(context).pop();
      });
      return alert;
    },
  );
}
