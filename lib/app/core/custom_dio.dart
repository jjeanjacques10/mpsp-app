import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:mpsp_app/app/services/user_service.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    _dio = Dio(_options);
  }

  CustomDio.withAuthentication() {
    _dio = Dio(_options);
    _dio
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) => requestInterceptor(options),
        onResponse: _onResponse,
        onError: _onError,
      ));
    _dio
      ..interceptors.add(DioCacheManager(
              CacheConfig(baseUrl: 'https://mpsp-wisen.herokuapp.com'))
          .interceptor);
  }

  BaseOptions _options = BaseOptions(
    baseUrl: 'https://mpsp-wisen.herokuapp.com',
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  dynamic requestInterceptor(RequestOptions options) async {
    var token = await UserService().getToken();
    options.headers.addAll({"Authorization": "Bearer $token"});
    return options;
  }

  _onResponse(Response e) {
    /*print('######### Response Log');
    print(e.data);
    print('######### Response Log');*/
  }

  _onError(DioError e) {
    if (e.response?.statusCode == 403 || e.response?.statusCode == 401) {
      UserService().logout();
    }
    return e;
  }

  Dio get instance => _dio;
}
