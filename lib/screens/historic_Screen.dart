import 'dart:html';

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
      body:SingleChildScrollView(
      child:
         static const _highLightColor = Color.fromRGBO(64, 75, 96, .1);
        static const _baseColor = Colors.white;
        static const _duration = Duration(milliseconds: 4000);
        Shimmer.fromColors(
        highlightColor: _highLightColor,
        baseColor: _baseColor,
        period: _duration,
        child: Container(
        height: 18,
        width: 40,
        color: _highLightColor,
        ),
        ),
       
    );
  }
}
