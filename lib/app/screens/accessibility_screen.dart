import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityScreen extends StatefulWidget {
  @override
  _AccessibilityScreenState createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acessibilidade'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GFListTile(
                avatar: Icon(
                  isSwitched == true
                      ? Icons.hearing_rounded
                      : Icons.hearing_disabled_rounded,
                  color: Colors.grey,
                ),
                titleText: 'Text-to-Speech',
                icon: Switch(
                  value: isSwitched,
                  onChanged: (value) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('text-to-speech', value.toString());
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.redAccent,
                  activeColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
