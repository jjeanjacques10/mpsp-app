import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesListItem extends StatefulWidget {
  final Messages messages;
  final UserModel userModel;

  MessagesListItem({this.messages, this.userModel});

  @override
  _MessagesListItemState createState() => _MessagesListItemState();
}

enum TtsState { playing, stopped }

class _MessagesListItemState extends State<MessagesListItem> {
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 2.0;
  double pitch = 1.2;
  double rate = 1.0;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage('pt-BR');
    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return widget.messages.ownerMessage != 'Maria Paula'
        ? _showSentMessage()
        : _showReceivedMessage();
  }

  Widget _showSentMessage() {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(45.0, 0.0, 0.0, 0.0),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://avatars3.githubusercontent.com/u/32225403?s=400&u=9c1a04035cc7b4e8749679fd87d0732c26a3dcd4&v=4'),
      ),
      title: Container(
        margin: EdgeInsets.only(left: 50),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(251, 65, 65, 1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Text(
          widget.messages.message,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15.2, color: Colors.white),
        ),
      ),
    );
  }

  Widget _showReceivedMessage() {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 45.0, 0.0),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/maria-paula.jpg'),
      ),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Text(
          widget.messages.message,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 15.2),
        ),
      ),
      trailing: _getTextToSpeech() != true
          ? Icon(
              Icons.hearing_rounded,
              color: Colors.grey[700],
            )
          : null,
      onTap: () {
        _onChange(widget.messages.message);
        _speak();
      },
    );
  }
}

_getTextToSpeech() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('text-to-speech');
  return id == 'true' ? true : false;
}
