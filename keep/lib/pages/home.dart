import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
