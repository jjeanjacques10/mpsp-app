import 'package:flutter/material.dart';
import 'package:mpsp_app/app/components/chat_message_list_item.dart';
import 'package:mpsp_app/app/components/show_alert_dialog.dart';
import 'package:mpsp_app/app/model/chat_message.dart';

class HistoricDetailsScreen extends StatefulWidget {
  @override
  _HistoricDetailsScreenState createState() => _HistoricDetailsScreenState();
}

class _HistoricDetailsScreenState extends State<HistoricDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ChatMessage chatMessage = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes de Atendimento'),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.download_rounded,
              ),
              onPressed: () {
                showAlertDialog(
                    context,
                    'Item Baixado',
                    Icon(
                      Icons.download_rounded,
                    ));
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Nome Bot: ${chatMessage.botName}',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Data: ${chatMessage.createdAt.toString()}',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Horário: ${chatMessage.createdAt.toString()}',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[600],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) =>
                      MessagesListItem(messages: chatMessage.messages[index]),
                  itemCount: chatMessage.messages.length,
                ),
              ),
            ],
          ),
        ));
  }
}
