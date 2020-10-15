import 'package:mpsp_app/app/core/custom_dio.dart';
import 'package:mpsp_app/app/model/service.dart';

class ServiceService {
  Future<List<ServiceModel>> findAll() async {
    final dio = CustomDio.withAuthentication().instance;

    return dio.get('/service').then((res) =>
        res.data.map<ServiceModel>((c) => ServiceModel.fromJson(c)).toList());
  }

  Future<List<ServiceModel>> getMessagesUserById(int id) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio.get('/service/' + (id != null ? id.toString() : '')).then(
        (res) => res.data
            .map<ServiceModel>((c) => ServiceModel.fromJson(c))
            .toList());
  }

  Future<void> create(ServiceModel service) async {
    final dio = CustomDio().instance;
    return dio.post('/service', data: service.toJson());
  }
}
