import 'package:flutter/material.dart';
import 'package:mpsp_app/app/methods/laucherURL.dart';

Card cardService(BuildContext context, Size size, String titulo, String img,
    String desc, String url) {
  var item = <Widget>[
    SizedBox(height: 25),
    GestureDetector(
      child: Center(
        child: Text(
          titulo,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () => launchURL(url),
    ),
  ];

  return Card(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1.0),
    ),
    child: Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                children: item,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
