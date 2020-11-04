import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/stores/historic_screen_store.dart';
import 'package:shimmer/shimmer.dart';

class HistoricScreen extends StatefulWidget {
  @override
  _HistoricScreenState createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  HistoricScreenStore historicScreenStore = HistoricScreenStore();

  static const _highLightColor = Color.fromRGBO(64, 75, 96, .1);
  static const _baseColor = Colors.black;
  static const _duration = Duration(milliseconds: 4000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Observer(builder: (ctx) {
        if (!historicScreenStore.isLoading) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: historicScreenStore.getListChats == null
                  ? 0
                  : historicScreenStore.getListChats.length,
              itemBuilder: (BuildContext ctx, int index) {
                ChatMessage chatMessage =
                    historicScreenStore.getListChats[index];
                return Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: GestureDetector(
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 18, bottom: 18, left: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "[22/11/2020 15:43] ${chatMessage.botName}: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("${chatMessage.type}"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/history-details',
                          arguments: chatMessage,
                        );
                      },
                    ));
              });
        } else {
          return ListView.builder(
              physics: ScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext ctx, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 18, bottom: 18, left: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Center(
                              child: Shimmer.fromColors(
                                highlightColor: _highLightColor,
                                baseColor: _baseColor,
                                period: _duration,
                                child: Container(
                                  height: 20,
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
              });
        }
      }),
    );
  }
}
