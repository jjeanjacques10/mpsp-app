import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpsp_app/app/screens/about_screen.dart';
import 'package:mpsp_app/app/screens/accessibility_screen.dart';
import 'package:mpsp_app/app/screens/historic_screen.dart';
import 'package:mpsp_app/app/screens/home_screen.dart';
import 'package:mpsp_app/app/screens/login_screen.dart';
import 'package:mpsp_app/app/screens/profile_screen.dart';
import 'package:mpsp_app/app/screens/register_screen.dart';
import 'package:mpsp_app/app/screens/watson_chat_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color.fromRGBO(197, 23, 24, 1), // navigation bar color
    statusBarColor: Color.fromRGBO(197, 23, 24, 1), // status bar color
  ));
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
        "/profile": (context) => ProfileScreen(),
        "/chat": (context) => WatsonChatScreen(),
        "/history": (context) => HistoricScreen(),
        "/accessibility": (context) => AccessibilityScreen(),
        "/about": (context) => AboutScreen(),
      },
    );
  }
}
