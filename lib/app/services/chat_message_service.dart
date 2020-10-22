import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/core/custom_dio.dart';

class ChatMessageService {
  Future<List<ChatMessage>> findAll() async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get(
          '/conversation',
          options: buildCacheOptions(Duration(days: 3), forceRefresh: true),
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

  Future<void> create(ChatMessage chatMessageModel) async {
    final dio = CustomDio.withAuthentication().instance;
    return dio.post('/conversation', data: chatMessageModel.toJson());
  }

  Future<void> sendMessage(Messages message) async {
    final dio = CustomDio.withAuthentication().instance;
    return dio.post('/message', data: message.toJson());
  }
}
