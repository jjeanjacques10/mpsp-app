import 'package:flutter/material.dart';
import 'package:mpsp_app/app/components/chat_message_list_item.dart';
import 'package:mpsp_app/app/components/choice_menu.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/services/chat_message_service.dart';
import 'package:mpsp_app/app/services/watson_assistant_v2.dart';

// ignore: must_be_immutable
class WatsonChatScreen extends StatefulWidget {
  WatsonChatScreen({Key key, this.userModel, this.title, this.typeChat})
      : super(key: key);

  final String title;
  UserModel userModel;
  String typeChat;

  @override
  _WatsonChatScreenState createState() => _WatsonChatScreenState();
}

class _WatsonChatScreenState extends State<WatsonChatScreen> {
  final _messageList = <Messages>[];
  final _controllerText = new TextEditingController();
  int idConversation = 1;
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
  List<WatsonAssistantResponse> watsonResultList =
      List<WatsonAssistantResponse>();
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  void _callWatsonAssistant(String textMessage) async {
    watsonResultList =
        await watsonAssistant.sendMessage(textMessage, watsonAssistantContext);
    for (var response in watsonResultList) {
      watsonAssistantResponse = response;

      setState(() {
        watsonAssistantContext = watsonAssistantResponse.context;
      });

      if (watsonAssistantResponse.resultText != "") {
        Messages message = new Messages(
            message: watsonAssistantResponse.resultText != null
                ? watsonAssistantResponse.resultText
                : 'Não entendi, poderia repetir?',
            ownerMessage: 'Maria Paula',
            idConversation: idConversation);

        await chatMessageService.sendMessage(message);

        setState(() {
          _addMessage(
              content: watsonAssistantResponse.resultText,
              type: ChatMessageType.received);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credential);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userModel == null) {
      widget.userModel = ModalRoute.of(context).settings.arguments;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Maria Paula'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        actions: <Widget>[
          PopupMenuButton<ChoiceMenu>(
            onSelected: (ChoiceMenu choice) async {
              setState(() {});
            },
            itemBuilder: (BuildContext ctx) {
              return choices.map((ChoiceMenu choice) {
                return PopupMenuItem<ChoiceMenu>(
                  enabled: choice.enabled,
                  value: choice,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (choice.route == "new") {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  // ignore: missing_return
                                  builder: (BuildContext ctx) =>
                                      WatsonChatScreen(
                                    userModel: widget.userModel,
                                    typeChat: 'new',
                                  ),
                                ),
                              );
                              /* Navigator.popAndPushNamed(
                                context,
                                '/chat',
                                arguments: WatsonChatScreen(
                                  userModel: widget.userModel,
                                  typeChat: 'new',
                                ),
                              ); */
                            } else {
                              Navigator.popAndPushNamed(
                                context,
                                "/history",
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                choice.icon,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(choice.title),
                              ),
                            ],
                          ))
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildList(),
              Divider(height: 1.0),
              _buildUserInput(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //_controllerText.dispose();
    super.dispose();
  }

  // Cria a lista de mensagens (de baixo para cima)
  Widget _buildList() {
    if (i == 1) {
      _populate();
      i++;
    }

    if (_messageList.length <= 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.grey[400],
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'Ainda não há mensagens',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      );
    }
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) {
          return MessagesListItem(
            messages: _messageList[index],
            userModel: widget.userModel,
          );
        },
        itemCount: _messageList.length,
      ),
    );
  }

  // Monta uma linha com o campo de text e o botão de enviao
  Widget _buildUserInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          _buildTextField(),
          _buildSendButton(),
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
  Widget _buildSendButton() {
    return new Container(
      margin: new EdgeInsets.only(left: 8.0),
      child: new IconButton(
          icon: new Icon(Icons.send, color: Theme.of(context).accentColor),
          onPressed: () {
            if (_controllerText.text.isNotEmpty) {
              _sendMessage(content: _controllerText.text);
            }
          }),
    );
  }

  // Envia uma mensagem com o padrão a direita
  void _sendMessage({
    String content,
  }) {
    String textMessage = _controllerText.text;

    Messages message = new Messages(
        message: _controllerText.text,
        ownerMessage: widget.userModel.name,
        idConversation: idConversation);
    chatMessageService.sendMessage(message);
    _controllerText.clear();

    _addMessage(
      content: content,
      type: ChatMessageType.sent,
    );

    _callWatsonAssistant(textMessage);
  }

  // Adiciona uma mensagem na lista de mensagens
  void _addMessage({
    String content,
    ChatMessageType type,
  }) {
    var message = Messages(
      message: content,
      ownerMessage:
          type == ChatMessageType.sent ? widget.userModel.name : 'Maria Paula',
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

  Future<void> _populate() async {
    if (widget.typeChat == 'new') {
      ChatMessage chat = await chatMessageService.create(ChatMessage(
        botName: 'Maria Paula',
        idUser: widget.userModel.id,
        type: 'Serviço 1',
      ));
      setState(() {
        idConversation = chat.id;
      });
    } else {
      chatMessageService.findAll().then((listMessages) {
        if (listMessages.isNotEmpty) {
          ChatMessage messages = listMessages[0];
          setState(() {
            idConversation = messages.id;
          });
          for (var message in messages.messages) {
            if (messages != null) {
              setState(() {
                _messageList.insert(0, message);
              });
            }
          }
        }
      }).catchError((onError) {
        print(onError);
      });
    }
  }
}

const List<ChoiceMenu> choices = const <ChoiceMenu>[
  const ChoiceMenu(
      title: 'Novo Atendimento', icon: Icons.add, enabled: true, route: "new"),
  const ChoiceMenu(
      title: 'Histórico',
      icon: Icons.restore,
      enabled: true,
      route: "historic"),
];
