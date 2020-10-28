import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AccessibilityScreen extends StatefulWidget {
  @override
  _AccessibilityScreenState createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool isSwitched = false;
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
                  Icons.translate,
                  color: Colors.grey,
                ),
                titleText: 'Text-to-Speech',
                icon: Switch(
                  value: isSwitched,
                  onChanged: (value) {
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
