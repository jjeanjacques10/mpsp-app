import 'package:flutter/material.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/screens/watson_chat_screen.dart';
import 'package:mpsp_app/app/utils/app_theme.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atendimento'),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, null);
          },
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton.icon(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              color: MPSPAppTheme.grey,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                "Novo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WatsonChatScreen(
                      userModel: userModel,
                      typeChat: 'new',
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
            RaisedButton.icon(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              color: MPSPAppTheme.grey,
              icon: Icon(
                Icons.forward,
                color: Colors.white,
              ),
              label: Text(
                "Continuar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WatsonChatScreen(
                      userModel: userModel,
                      typeChat: 'continue',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
