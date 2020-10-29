import 'package:mpsp_app/app/core/custom_dio.dart';
import 'package:mpsp_app/app/model/chat_message.dart';

class ChatMessageService {
  Future<List<ChatMessage>> findAll({int limit = 1}) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get(
          '/conversation/user/?limit=${limit.toString()}',
        )
        .then((res) =>
            res.data.map<ChatMessage>((c) => ChatMessage.fromJson(c)).toList());
  }

  Future<ChatMessage> getMessagesUserById(int id, {int userId}) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get(
          '/conversation/' + (id != null ? id.toString() : ''),
        )
        .then((res) => ChatMessage.fromJson(res.data));
  }

  Future<dynamic> create(ChatMessage chatMessageModel) async {
    final dio = CustomDio.withAuthentication().instance;
    return dio
        .post('/conversation', data: chatMessageModel.toJson())
        .then((res) => ChatMessage.fromJson(res.data));
  }

  Future<void> sendMessage(Messages message) async {
    final dio = CustomDio.withAuthentication().instance;
    return dio.post('/message', data: message.toJson());
  }
}
