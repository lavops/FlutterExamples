import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoom/json/home_json.dart';
import 'package:zoom/theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerAndFooter,
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: headerAndFooter,
      centerTitle: true, // default false
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.settings,
            color: grey,
          ),
          Spacer(),
          Row(
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: activeTab == index ? grey : grey.withOpacity(0.2),
                      shape: BoxShape.circle),
                ),
              );
            }),
          ),
          Spacer()
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 150,
      decoration: BoxDecoration(color: headerAndFooter),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width * 0.75,
              height: 50,
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Join a Meeting",
                  style: TextStyle(
                      color: grey, fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {}
}
