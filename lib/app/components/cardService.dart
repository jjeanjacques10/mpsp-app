import 'package:flutter/material.dart';

Card cardService(BuildContext context, Size size, String titulo, String img,
    String desc, String url) {
  var item = <Widget>[
    SizedBox(height: 25),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Text(
                    titulo,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0x003B50).withOpacity(1),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/web",
                  arguments: url,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ];

  return Card(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1.0),
    ),
    child: Container(
      //height: size.height * .19,
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
