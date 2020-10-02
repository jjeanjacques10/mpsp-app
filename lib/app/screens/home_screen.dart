import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mpsp_app/app/model/User.dart';
import 'package:mpsp_app/app/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService userService = UserService();

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
                }),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                //Deslogar()
                userService.logout();
                Navigator.pushReplacementNamed(
                  context,
                  "/",
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            debugPrint('Entrar no chat');
          },
          child: Icon(
            Icons.forum,
            size: 35,
          ),
          backgroundColor: Color.fromRGBO(197, 23, 24, 1),
        ),
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
              SizedBox(height: 5),
              Text(
                "Bem vindo,",
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "NOME PERFIL",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notícias",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(height: 150.0),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(197, 23, 24, 1),
                                ),
                                child: Center(
                                  child: Text('Notícia $i',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      )),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Serviços",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 1",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 2",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 3",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 4",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 5",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 6",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 7",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 8",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.grey[800],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Serviço 9",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat',
                              arguments: UserModel(id: 1));
                        },
                        child: Icon(Icons.keyboard_arrow_down, size: 70),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
