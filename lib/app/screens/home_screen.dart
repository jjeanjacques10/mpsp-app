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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "userModel.name",
                style: TextStyle(fontSize: 22),
              ),
              accountEmail: Text(
                "userModel.email",
                style: TextStyle(fontSize: 15),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage("assets/images/mpsp-logo.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Perfil"),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                    //arguments: userModel,
                  ).then((value) {
                    setState(() {
                      // userModel = value;
                    });
                  });
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
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: UserModel(id: 1));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bem vindo,",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 40,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.openEndDrawer();
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                ],
              ),
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
                      options: CarouselOptions(
                        height: 150.0,
                        viewportFraction: 0.75,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 7),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      items: [1, 2, 3, 4].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Image.asset(
                                      'assets/images/servico$i.jpg'),
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
                                  "Procuradoria-Geral",
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
                                  "Atendimento ao Inativo",
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
                                  "Biblioteca",
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
                                  "CTIC",
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
                                  "Demonstrativo on-line",
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
                                  "Diário Oficial",
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
                                  "e-funcional",
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
                                  "Email Institucional",
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
                                  "Formulários Administrativos",
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
                        onPressed: () {},
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
