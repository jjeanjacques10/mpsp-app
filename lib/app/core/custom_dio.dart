import 'package:dio/dio.dart';
import 'package:mpsp_app/app/services/user_service.dart';

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
    baseUrl: 'https://mpsp-wisen.herokuapp.com/',
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  _onRequest(RequestOptions options) async {
    var token = await UserService().getToken();
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

  Dio get instance => _dio;
}
