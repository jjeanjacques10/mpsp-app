library watson_assistant_v2;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String sessionPref;

class WatsonAssistantResponse {
  String resultText;
  WatsonAssistantContext context;
  WatsonAssistantResponse({this.resultText, this.context});
}

class WatsonAssistantContext {
  Map<String, dynamic> context;

  WatsonAssistantContext({
    this.context,
  });

  void resetContext() {
    this.context = {};
  }
}

class WatsonAssistantV2Credential {
  String username;
  String apikey;
  String version;
  String url;
  String assistantID;

  WatsonAssistantV2Credential({
    this.username = 'apikey',
    @required this.apikey,
    this.version = "2019-02-28",
    /*
    Service endpoint

     The service endpoint is based on the location of the service instance.
     For example, when Watson Assistant is hosted in Frankfurt, the base URL is https://gateway-fra.watsonplatform.net/assistant/api/v2.
     The URL might also be different when you use IBM Cloud Dedicated.
     */
    @required this.url,
    // example this.url = 'https://gateway-lon.watsonplatform.net/assistant/api/v2',
    @required this.assistantID,
  });
}

class WatsonAssistantApiV2 {
  WatsonAssistantV2Credential watsonAssistantCredential;

  WatsonAssistantApiV2({
    @required this.watsonAssistantCredential,
  });
  Future<WatsonAssistantResponse> sendMessage(
      String textInput, WatsonAssistantContext context) async {
    try {
      String urlWatsonAssistant =
          "${watsonAssistantCredential.url}/assistants/${watsonAssistantCredential.assistantID}/sessions?version=${watsonAssistantCredential.version}";

      //Authentication
      //IBM Cloud is migrating to token-based Identity and Access Management (IAM) authentication.

      var authn = 'Basic ' +
          base64Encode(utf8.encode(
              '${watsonAssistantCredential.username}:${watsonAssistantCredential.apikey}'));

      Map<String, dynamic> _body = {
        "input": {"text": textInput},
        "context": context.context,
        "options": {"return_context": true}
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();
      sessionPref = prefs.getString('sessionPref');

      //Create a new session.
      // A session is used to send user input to a skill and receive responses.
      // It also maintains the state of the conversation.
      String session_id;
      if (sessionPref != null && sessionPref != "") {
        session_id = sessionPref;
      } else {
        var newSess = await http.post(
            '${watsonAssistantCredential.url}/assistants/${watsonAssistantCredential.assistantID}/sessions?version=${watsonAssistantCredential.version}',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': authn
            },
            body: json.encode(_body));
        try {
          if (newSess.statusCode != 201) {
            //throw Exception('Failed to load post');
            throw Exception('post error: statusCode= ${newSess.statusCode}');
          }
        } on Exception {
          print('Failed to load post');
          print(newSess.statusCode);
        }
        //Create a new session. A session is used to send user input to a skill and receive responses. It also maintains the state of the conversation.
        print(newSess.body);
        var parsedJsonSession = json.decode(newSess.body);
        session_id = parsedJsonSession['session_id'];
        prefs.setString('sessionPref', parsedJsonSession['session_id']);
      }
      /* print('the session $session_id is created');*/

      var receivedText = await http.post(
        '${watsonAssistantCredential.url}/assistants/${watsonAssistantCredential.assistantID}/sessions/$session_id/message?version=${watsonAssistantCredential.version}',
        headers: {'Content-Type': 'application/json', 'Authorization': authn},
        body: json.encode(_body),
        //body: data
      );
      print(receivedText);
      /* print(receivedText.statusCode);
      print(receivedText.body);*/

      var parsedJson = json.decode(receivedText.body);
      var _WatsonResponse = parsedJson['output']['generic'][0]['text'];

      Map<String, dynamic> _result = json.decode(receivedText.body);

      print('this is result : $_result');
      WatsonAssistantContext _context =
          WatsonAssistantContext(context: _result['context']);

      WatsonAssistantResponse watsonAssistantResult = WatsonAssistantResponse(
          context: _context, resultText: _WatsonResponse);
      return watsonAssistantResult;
    } catch (error) {
      //print(error);
      return error;
    }
  }
}
