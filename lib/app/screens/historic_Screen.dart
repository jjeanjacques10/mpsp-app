import 'package:flutter/material.dart';

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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "[22/11/2020 15:43] Maria Paula: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Lorem ipsum dollor"),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
