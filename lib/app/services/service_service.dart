import 'package:mpsp_app/app/core/custom_dio.dart';
import 'package:mpsp_app/app/model/service.dart';

class ServiceService {
  Future<List<ServiceModel>> findAll() async {
    final dio = CustomDio.withAuthentication().instance;

    return dio.get('/service').then((res) =>
        res.data.map<ServiceModel>((c) => ServiceModel.fromJson(c)).toList());
  }

  Future<List<ServiceModel>> getMessagesUserById(int id, {int userId}) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get('/service?userId=' + (userId != null ? userId.toString() : ''))
        .then((res) => res.data
            .map<ServiceModel>((c) => ServiceModel.fromJson(c))
            .toList());
  }

  Future<void> create(ServiceModel service) async {
    final dio = CustomDio().instance;
    return dio.post('/service', data: service.toJson());
  }
}
