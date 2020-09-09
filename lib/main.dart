import 'package:flutter/material.dart';
import 'package:mpsp_app/screens/home_screen.dart';
import 'package:mpsp_app/screens/login_screen.dart';
import 'package:mpsp_app/screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        "/": (context) => RegisterScreen(),
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
      },
    );
  }
}
