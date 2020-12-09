import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mpsp_app/app/components/show_alert_dialog.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:path/path.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:file_picker/file_picker.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  File localFile;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserModel userModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'update');
          },
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              localFile == null
                  ? RaisedButton.icon(
                      textColor: Colors.white,
                      color: Colors.red,
                      icon: Icon(MdiIcons.filePdf),
                      label: Text("Escolher Documento"),
                      onPressed: () async {
                        File file = await FilePicker.getFile(
                            allowedExtensions: ['pdf'], type: FileType.custom);
                        setState(() {
                          localFile = file;
                        });
                      },
                    )
                  : RaisedButton.icon(
                      textColor: Colors.white,
                      color: Colors.red,
                      icon: Icon(MdiIcons.filePdf),
                      label: Text("${basename(localFile.path)}"),
                      onPressed: () async {
                        File file = await FilePicker.getFile(
                            allowedExtensions: ['pdf'], type: FileType.custom);
                        setState(() {
                          localFile = file;
                        });
                      },
                    ),
              ListTile(
                title: localFile != null
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          PDF.file(
                            localFile,
                            height: 490,
                            width: 390,
                            placeHolder: Image.asset("assets/images/pdf.png",
                                height: 200, width: 100),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          try {
            if (_formKey.currentState.validate()) {
              showAlertDialog(
                  context, 'Documento enviado com sucesso!', Icon(Icons.check));
              /*   SnackBar snackBar = SnackBar(
                content: Text('Documento Enviado com sucesso!'),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar); */
            }
          } on Exception catch (e, s) {
            print(s);
          }
        },
        label: Container(
          child: Text(
            'Enviar',
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.ltr,
            maxLines: 2,
          ),
        ),
        icon: Icon(Icons.send),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
