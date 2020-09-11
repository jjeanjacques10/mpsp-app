import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class HistoricScreen extends StatefulWidget {
  @override
  _HistoricScreenState createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Shimmer.fromColors(
          highlightColor: Color.fromRGBO(64, 75, 96, .1),
          baseColor: Colors.white,
          period: Duration(milliseconds: 4000),
          child: Container(
            height: 18,
            width: 40,
            color: Color.fromRGBO(64, 75, 96, .1),
          ),
        ),
      ),
    );
  }
}
