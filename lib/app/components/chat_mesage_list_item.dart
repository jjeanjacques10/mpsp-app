import 'package:flutter/material.dart';
import 'package:mpsp_app/app/model/User.dart';
import 'package:mpsp_app/app/model/chat_message.dart';

class MessagesListItem extends StatelessWidget {
  final Messages messages;
  final UserModel userModel;

  MessagesListItem({this.messages, this.userModel});

  @override
  Widget build(BuildContext context) {
    return messages.ownerMessage != 'Alice'
        ? _showSentMessage()
        : _showReceivedMessage();
  }

  Widget _showSentMessage({EdgeInsets padding, TextAlign textAlign}) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(64.0, 0.0, 8.0, 0.0),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://avatars3.githubusercontent.com/u/32225403?s=400&u=9c1a04035cc7b4e8749679fd87d0732c26a3dcd4&v=4'),
      ),
      title: Container(
        margin: EdgeInsets.only(left: 50),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(17.0),
          ),
        ),
        child: Text(
          messages.message,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _showReceivedMessage() {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 64.0, 0.0),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/mpsp-logo.png'),
      ),
      title: Text(
        messages.message,
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
