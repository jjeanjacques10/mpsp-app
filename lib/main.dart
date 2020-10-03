import 'package:flutter/material.dart';
import 'package:mpsp_app/app/screens/home_screen.dart';
import 'package:mpsp_app/app/screens/login_screen.dart';
import 'package:mpsp_app/app/screens/register_screen.dart';
import 'package:mpsp_app/app/screens/chat_screen.dart';

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
        "/home": (context) => HomeScreen(),
        "/register": (context) => RegisterScreen(),
        "/login": (context) => LoginScreen(),
        "/chat": (context) => ChatScreen(),
      },
    );
  }
}
