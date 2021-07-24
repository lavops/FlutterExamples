import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text(
              "It's cloudy here",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.userCircle),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text("Exhibition"),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.filter),
          onPressed: () {},
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.search),
          onPressed: () {},
        )
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Center(
            child: Text(
              "List",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              "Map",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
