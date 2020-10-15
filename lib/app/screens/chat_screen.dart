import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:mpsp_app/app/components/chat_message_list_item.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/services/chat_message_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageList = <ChatMessage>[];
  final _controllerText = new TextEditingController();
  int i = 1;
  UserModel userModel;
  ChatMessageService chatMessageService = ChatMessageService();

  @override
  void dispose() {
    super.dispose();
    _controllerText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: new AppBar(
        title: Text('Maria Paula'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          _buildList(),
          Divider(height: 1.0),
          _buildUserInput(userModel),
        ],
      ),
    );
  }

  // Cria a lista de mensagens (de baixo para cima)
  Widget _buildList() {
    if (i == 1) {
      _populate(userModel);
      i++;
    }
/*     return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => ChatMessageListItem(
            chatMessage: _messageList[index], userModel: userModel),
        itemCount: _messageList.length,
      ),
    ); */
  }

  // Envia uma mensagem com o padrão a direita
  void _sendMessage({String content, UserModel userModel}) {
    _controllerText.clear();
    _addMessage(
      name: userModel.name,
      content: content,
      type: ChatMessageType.sent,
      userId: userModel.id,
    );
  }

  // Adiciona uma mensagem na lista de mensagens
  void _addMessage(
      {String name, String content, ChatMessageType type, int userId}) {
    /*var message = Messages(
      mess: name,
      content: content,
      type: type,
      userId: userModel.id,
    );
    setState(() {
      _messageList.insert(0, message);
    });

    if (type == ChatMessageType.sent) {
      // Envia a mensagem para o chatbot e aguarda sua resposta
      _dialogFlowRequest(query: message.messages[0].message);
    }
    if (message.content != "Escrevendo...") {
      chatMessageService.create(message);
    }*/
  }

  // Campo para escrever a mensagem
  Widget _buildTextField() {
    return new Flexible(
      child: new TextField(
        controller: _controllerText,
        decoration: new InputDecoration.collapsed(
          hintText: "Enviar mensagem",
        ),
      ),
    );
  }

  // Botão para enviar a mensagem
  Widget _buildSendButton(UserModel userModel) {
    return new Container(
      margin: new EdgeInsets.only(left: 8.0),
      child: new IconButton(
          icon: new Icon(Icons.send, color: Theme.of(context).accentColor),
          onPressed: () {
            if (_controllerText.text.isNotEmpty) {
              _sendMessage(content: _controllerText.text, userModel: userModel);
            }
          }),
    );
  }

  // Monta uma linha com o campo de text e o botão de enviao
  Widget _buildUserInput(UserModel userModel) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          _buildTextField(),
          _buildSendButton(userModel),
        ],
      ),
    );
  }

  Future _dialogFlowRequest({String query}) async {
    // Adiciona uma mensagem temporária na lista
    _addMessage(
        name: 'Elisa',
        content: 'Escrevendo...',
        type: ChatMessageType.received);

    // Faz a autenticação com o serviço, envia a mensagem e recebe uma resposta da Intent
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: "pt-BR");
    AIResponse response = await dialogflow.detectIntent(query);

    // remove a mensagem temporária
    setState(() {
      _messageList.removeAt(0);
    });

    // adiciona a mensagem com a resposta do DialogFlow
    _addMessage(
        name: 'Elisa',
        content: response.getMessage() ?? '',
        type: ChatMessageType.received);
  }

  void _populate(UserModel userModel) {
    chatMessageService.getMessagesUserById(userModel.id).then((messages) {});
  }
}
