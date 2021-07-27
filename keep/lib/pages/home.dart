import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keep/json/notes_json.dart';
import 'package:keep/pages/sidemenu.dart';
import 'package:keep/theme/colors.dart';
import 'package:keep/widgets/header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: bgColor,
      drawer: SideMenuPage(),
      body: buildBody(),
      bottomSheet: buildBottomBar(),
      floatingActionButton: buildFAB(),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      // SafeArea is important for not going behind top bar
      child: ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          // Drawer button, Search, Profile Icon
          Header(size: size, drawerKey: _drawerKey),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "PINNED",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: white.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildGrid(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGrid() {
    var size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(notes.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: white.withOpacity(0.1),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    notes[index]['title'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Description
                  Text(
                    notes[index]['description'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: white.withOpacity(0.7),
                    ),
                  ),
                  // Person Icons
                  Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: List.generate(notes[index]['img'].length,
                            (indexImg) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: white.withOpacity(0.1),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      notes[index]['img'][indexImg]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildBottomBar() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 50,
      decoration: BoxDecoration(color: bgColor, boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
              width: size.width * 0.7,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      AntDesign.checksquare,
                      size: 20,
                      color: white.withOpacity(0.5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesome.paint_brush,
                      size: 18,
                      color: white.withOpacity(0.5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic_rounded,
                      size: 22,
                      color: white.withOpacity(0.5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      MaterialIcons.photo,
                      size: 22,
                      color: white.withOpacity(0.5),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: bgColor,
      child: Center(
        child: SvgPicture.asset(
          "assets/images/google_icon.svg",
          width: 30,
        ),
      ),
    );
  }
}
