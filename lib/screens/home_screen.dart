import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Home Page',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ), */
        endDrawerEnableOpenDragGesture: true,
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Perfil"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/profile',
                      arguments: null,
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.warning),
                  title: Text("Denunciar abuso"),
                  onTap: () {
                    debugPrint('Ativei denúncia');
                  }),
              ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Sair"),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('Entrar no chat');
          },
          child: Icon(Icons.chat),
		  backgroundColor: Color.fromRGBO(197, 23, 24, 1),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem vindo,",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "NOME PERFIL",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(
                          "Notícias",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Serviços",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text("He'd have you all unravel at the"),
                        color: Colors.teal[100],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Heed not the rabble'),
                        color: Colors.teal[200],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Sound of screams but the'),
                        color: Colors.teal[300],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Who scream'),
                        color: Colors.teal[400],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Revolution is coming...'),
                        color: Colors.teal[500],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Revolution, they...'),
                        color: Colors.teal[600],
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
