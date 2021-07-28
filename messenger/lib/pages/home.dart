import 'package:flutter/material.dart';
import 'package:messenger/json/data.dart';
import 'package:messenger/theme/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
        ),
        children: [
          // AppBar
          buildAppBar(),
          SizedBox(
            height: 10,
          ),
          // Search box
          buildSearchBox(),
          SizedBox(
            height: 30,
          ),
          // Stories
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(profilePicture),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          "Chats",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(Icons.edit),
      ],
    );
  }

  Widget buildSearchBox() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorColor: black,
        controller: _searchControler,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: black.withOpacity(0.5),
          ),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
