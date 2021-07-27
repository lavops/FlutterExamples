import 'package:flutter/material.dart';
import 'package:keep/theme/colors.dart';

class SideMenuDetailPage extends StatefulWidget {
  final String title;

  const SideMenuDetailPage({Key? key, required this.title}) : super(key: key);

  @override
  _SideMenuDetailPageState createState() => _SideMenuDetailPageState();
}

class _SideMenuDetailPageState extends State<SideMenuDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: cardColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: 22,
          color: white.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Center(
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 18,
          color: white.withOpacity(0.7),
        ),
      ),
    );
  }
}
