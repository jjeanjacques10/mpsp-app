import 'package:flutter/material.dart';
import 'package:mpsp_app/app/components/chat_message_list_item.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/services/chat_message_service.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';

class WatsonChatScreen extends StatefulWidget {
  WatsonChatScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WatsonChatScreenState createState() => _WatsonChatScreenState();
}

class _WatsonChatScreenState extends State<WatsonChatScreen> {
  final _messageList = <Messages>[];
  final _controllerText = new TextEditingController();
  final idConversation = 1;

  var i = 1;

  ChatMessageService chatMessageService = ChatMessageService();

  WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
    version: '2019-02-28',
    username: 'apikey',
    apikey: 'K9EdEdbIdEY2Hu6LrNKIctN7oEQmdpSJgVTStLQ2uxOp',
    assistantID: '55bc625c-5598-40d6-90e1-eb071c10409e',
    url:
        'https://api.us-south.assistant.watson.cloud.ibm.com/instances/0164d69a-68f0-433d-9e01-abc1344a34a5/v2',
  );

  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        _controllerText.text, watsonAssistantContext);
    Messages message = new Messages(
        message: watsonAssistantResponse.resultText,
        ownerMessage: 'Maria Paula',
        idConversation: idConversation);
    await chatMessageService.sendMessage(message);
    setState(() {
      _addMessage(
          content: watsonAssistantResponse.resultText,
          type: ChatMessageType.received);
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    _controllerText.clear();
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credential);
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Maria Paula'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.restore,
            ),
            onPressed: () {
              watsonAssistantContext.resetContext();
            },
          )
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildList(userModel),
              Divider(height: 1.0),
              _buildUserInput(userModel),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerText.dispose();
    super.dispose();
  }

  // Cria a lista de mensagens (de baixo para cima)
  Widget _buildList(UserModel userModel) {
    if (i == 1) {
      _populate(userModel);
      i++;
    }
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => MessagesListItem(
            messages: _messageList[index], userModel: userModel),
        itemCount: _messageList.length,
      ),
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

  // Envia uma mensagem com o padrão a direita
  void _sendMessage({String content, UserModel userModel}) {
    Messages message = new Messages(
        message: _controllerText.text,
        ownerMessage: userModel.name,
        idConversation: idConversation);
    chatMessageService.sendMessage(message);
    _addMessage(
        content: content, type: ChatMessageType.sent, userModel: userModel);
    _callWatsonAssistant();
  }

  // Adiciona uma mensagem na lista de mensagens
  void _addMessage(
      {String content, ChatMessageType type, UserModel userModel}) {
    var message = Messages(
      message: content,
      ownerMessage: type == ChatMessageType.sent ? userModel.name : 'Alice',
    );
    print(message);

    setState(() {
      _messageList.insert(0, message);
    });

    if (type == ChatMessageType.sent) {
      // Envia a mensagem para o chatbot e aguarda sua resposta
      //_dialogFlowRequest(query: message.messages[0].message);
    }
    if (message.message != "Escrevendo...") {
      //chatMessageService.create(message);
    }
  }

  void _populate(UserModel userModel) {
    //chatMessageService.getMessagesUserById(userModel.id).then((messages) {
    chatMessageService.getMessagesUserById(idConversation).then((messages) {
      print(messages);
      for (var message in messages.messages) {
        if (messages != null) {
          setState(() {
            _messageList.insert(0, message);
          });
        }
      }
    });
  }
}
