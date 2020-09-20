import 'package:dio/dio.dart';
import 'package:mpsp_app/app/services/user_repository.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    _dio = Dio(_options);
  }

  CustomDio.withAuthentication() {
    _dio = Dio(_options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }

  BaseOptions _options = BaseOptions(
    baseUrl: 'http://192.168.0.107:3000',
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  Dio get instance => _dio;

  _onRequest(RequestOptions options) async {
    var token = await UserRepository().getToken();
    options.headers['Authorization'] = token;
  }

  _onResponse(Response e) {
    /*print('######### Response Log');
    print(e.data);
    print('######### Response Log');*/
  }

  _onError(DioError e) {
    return e;
  }
}
