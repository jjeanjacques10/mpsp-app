import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:mpsp_app/app/core/custom_dio.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<bool> isLogged() async {
    final String token = await this.getToken();
    return token != null;
  }

  Future<bool> login(String email, String password) {
    final dio = CustomDio().instance;
    try {
      return dio.post('/auth',
          data: {'email': email, 'password': password}).then((res) async {
        //print(res.data['token']);
        final String token = res.data['token'];
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          prefs.setString('id', res.data['user']['id'].toString());
          prefs.setString('name', res.data['user']['name']);
          prefs.setString('email', res.data['user']['email']);
          return true;
        }

        return false;
      }).catchError((err) {
        print(err);
        return false;
      });
    } catch (err) {
      print(err);
      return Future.value(false);
    }
  }

  Future<bool> loginFacebook(Map data) {
    final dio = CustomDio().instance;
    try {
      return dio.post('/auth-facebook', data: data).then((res) async {
        //print(res.data['token']);
        final String token = res.data['token'];
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          prefs.setString('id', res.data['user']['id_user'].toString());
          prefs.setString('name', res.data['user']['name']);
          prefs.setString('email', res.data['user']['email']);
          return true;
        }

        return false;
      }).catchError((err) {
        print(err);
        return false;
      });
    } catch (err) {
      print(err);
      return Future.value(false);
    }
  }

  Future<bool> loginGoogle(Map data) {
    final dio = CustomDio().instance;
    try {
      return dio.post('/auth-google', data: data).then((res) async {
        //print(res.data['token']);
        final String token = res.data['token'];
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          prefs.setString('id', res.data['user']['id_user'].toString());
          prefs.setString('name', res.data['user']['name']);
          prefs.setString('email', res.data['user']['email']);
          return true;
        }

        return false;
      }).catchError((err) {
        print(err);
        return false;
      });
    } catch (err) {
      print(err);
      return Future.value(false);
    }
  }

  Future<UserModel> findById(int id) async {
    final dio = CustomDio.withAuthentication().instance;

    return dio
        .get(
          '/user/$id',
          options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
        )
        .then((res) => UserModel.fromJson(res.data))
        .catchError((onError) {
      print(onError);
    });
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> create(UserModel user) async {
    final dio = CustomDio().instance;
    return dio.post('/user', data: user.toJson());
  }

  Future<void> update(UserModel user) async {
    final dio = CustomDio.withAuthentication().instance;
    return dio.put('/user/${user.id}', data: user.toJson());
  }
}
