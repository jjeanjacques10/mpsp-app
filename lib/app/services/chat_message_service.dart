import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/core/custom_dio.dart';

class ChatMessageService {
  Future<List<ChatMessage>> findAll() async {
    final dio = CustomDio.withAuthentication().instance;

    return dio.get('/conversation').then((res) =>
        res.data.map<ChatMessage>((c) => ChatMessage.fromJson(c)).toList());
  }

  Future<List<ChatMessage>> getMessagesUserById(int id, {int userId}) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get(
            '/conversation?userId=' + (userId != null ? userId.toString() : ''))
        .then((res) =>
            res.data.map<ChatMessage>((c) => ChatMessage.fromJson(c)).toList());
  }

  Future<void> create(ChatMessage chatMessageModel) async {
    final dio = CustomDio().instance;
    return dio.post('/conversation', data: chatMessageModel.toJson());
  }
}
