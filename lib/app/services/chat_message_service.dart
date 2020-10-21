import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/core/custom_dio.dart';

class ChatMessageService {
  Future<List<ChatMessage>> findAll() async {
    final dio = CustomDio.withAuthentication().instance;

    return dio.get('/conversation').then((res) =>
        res.data.map<ChatMessage>((c) => ChatMessage.fromJson(c)).toList());
  }

  Future<ChatMessage> getMessagesUserById(int id, {int userId}) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get(
          '/conversation/' + (id != null ? id.toString() : ''),
          options: buildCacheOptions(Duration(days: 5)),
        )
        .then((res) => ChatMessage.fromJson(res.data));
  }

  Future<void> create(ChatMessage chatMessageModel) async {
    final dio = CustomDio().instance;
    return dio.post('/conversation', data: chatMessageModel.toJson());
  }
}
