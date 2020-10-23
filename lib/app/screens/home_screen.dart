import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mpsp_app/app/components/card_service.dart';
import 'package:mpsp_app/app/model/service.dart';
import 'package:mpsp_app/app/services/user_service.dart';
import 'package:mpsp_app/app/stores/home_screen_store.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mpsp_app/app/methods/laucherURL.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService userService = UserService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreenStore homeScreenStore;
  static const _highLightColor = Color.fromRGBO(64, 75, 96, .1);
  static const _baseColor = Colors.black;
  static const _duration = Duration(milliseconds: 4000);

  @override
  Widget build(BuildContext context) {
    homeScreenStore = HomeScreenStore();
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Observer(builder: (ctx) {
              if (!homeScreenStore.isLoading) {
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    homeScreenStore.name != null ? homeScreenStore.name : '',
                    style: TextStyle(fontSize: 22),
                  ),
                  accountEmail: Text(
                    homeScreenStore.user.email != null
                        ? homeScreenStore.user.email
                        : '',
                    style: TextStyle(fontSize: 15),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                    backgroundColor: Colors.transparent,
                  ),
                );
              } else {
                if (homeScreenStore.name.isEmpty) {
                  return UserAccountsDrawerHeader(
                    accountName: Shimmer.fromColors(
                      highlightColor: _highLightColor,
                      baseColor: _baseColor,
                      period: _duration,
                      child: Container(
                        height: 25,
                        width: 170,
                        color: _highLightColor,
                      ),
                    ),
                    accountEmail: Shimmer.fromColors(
                      highlightColor: _highLightColor,
                      baseColor: _baseColor,
                      period: _duration,
                      child: Container(
                        height: 25,
                        width: 100,
                        color: _highLightColor,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }
                return UserAccountsDrawerHeader(
                  accountName: Shimmer.fromColors(
                    highlightColor: _highLightColor,
                    baseColor: _baseColor,
                    period: _duration,
                    child: Container(
                      height: 25,
                      width: 170,
                      color: _highLightColor,
                    ),
                  ),
                  accountEmail: Shimmer.fromColors(
                    highlightColor: _highLightColor,
                    baseColor: _baseColor,
                    period: _duration,
                    child: Container(
                      height: 25,
                      width: 100,
                      color: _highLightColor,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }
            }),
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
                leading: Icon(Icons.restore),
                title: Text("Histórico de atendimentos"),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/history',
                    //arguments: userModel,
                  );
                }),
            ListTile(
                leading: Icon(Icons.accessibility),
                title: Text("Acessibilidade"),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/accessibility',
                    //arguments: userModel,
                  );
                }),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Sair"),
                onTap: () {
                  userService.logout();
                  Navigator.pushNamed(context, '/login');
                }),
            SizedBox(height: 320),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.email, color: Colors.grey),
                        onPressed: () => launchURL('http://www.mpsp.mp.br/portal/page/portal/Promotorias_de_Justica/emails_promotorias'),
                      ),
                      IconButton(
                        icon: Icon(Icons.phone, color: Colors.grey),
                        onPressed: () => launchURL('http://www.mpsp.mp.br/portal/page/portal/lista_telefonica'),
                      ),
                      IconButton(
                        icon: Icon(Icons.headset_mic, color: Colors.grey),
                        onPressed: () => launchURL('https://sis.mpsp.mp.br/atendimentocidadao/Ouvidoria/Manifestacao/EscolherTipoDeIdentificacao'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/chat',
                arguments: homeScreenStore.user);

            debugPrint('Entrar no chat');
          },
          child: Icon(
            Icons.forum,
            size: 35,
          ),
          backgroundColor: Color.fromRGBO(197, 23, 24, 1),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          primary: false,
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
              Observer(builder: (ctx) {
                if (!homeScreenStore.isLoading) {
                  return Text(
                    homeScreenStore.user.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Shimmer.fromColors(
                    highlightColor: _highLightColor,
                    baseColor: _baseColor,
                    period: _duration,
                    child: Container(
                      height: 25,
                      width: 100,
                      color: _highLightColor,
                    ),
                  );
                }
              }),
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
                    Observer(builder: (ctx) {
                      if (!homeScreenStore.isLoading) {
                        return SizedBox(
                          height: 450,
                          child: GridView.builder(
                              physics:
                                  ScrollPhysics(), // to disable GridView's scrolling
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 4 / 2,
                              ),
                              itemCount: homeScreenStore.filtered == null
                                  ? 0
                                  : homeScreenStore.filtered.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                ServiceModel serviceModel =
                                    homeScreenStore.filtered[index];
                                return cardService(
                                    context,
                                    Size(0, 11),
                                    serviceModel.name,
                                    'img',
                                    'desc',
                                    serviceModel.url);
                              }),
                        );
                      } else {
                        //return Center(child: CircularProgressIndicator());
                        return SizedBox(
                            height: 450,
                            child: GridView.builder(
                                physics:
                                    ScrollPhysics(), // to disable GridView's scrolling
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4 / 2,
                                ),
                                itemCount: 10,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Card(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
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
                                                borderRadius:
                                                    BorderRadius.circular(29),
                                              ),
                                              child: Center(
                                                child: Shimmer.fromColors(
                                                  highlightColor:
                                                      _highLightColor,
                                                  baseColor: _baseColor,
                                                  period: _duration,
                                                  child: Container(
                                                    height: 25,
                                                    width: 100,
                                                    color: _highLightColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
