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

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> cadastrarUser(UserModel user) async {
    final dio = CustomDio().instance;
    return dio.post('/user', data: user.toJson());
  }
}
