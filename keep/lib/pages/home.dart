import 'package:flutter/material.dart';
import 'package:keep/pages/sidemenu.dart';
import 'package:keep/theme/colors.dart';

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
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              width: size.width,
              height: 45,
              decoration: BoxDecoration(
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Drawer
                            _drawerKey.currentState?.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: white.withOpacity(0.7),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
