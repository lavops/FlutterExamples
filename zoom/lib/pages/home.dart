import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoom/json/home_json.dart';
import 'package:zoom/pages/join_meeting.dart';
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
                    shape: BoxShape.circle,
                  ),
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
            // Join Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => JoinMeetingPage(),
                  ),
                );
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Join a Meeting",
                    style: TextStyle(
                      color: grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            // Sign Up and Sign In
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;
    var options = CarouselOptions(
      viewportFraction: 0.99,
      height: size.height,
      onPageChanged: (index, reason) {
        setState(() {
          activeTab = index;
        });
      },
    );

    return CarouselSlider(
      items: List.generate(items.length, (index) {
        return Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Title and Description
              Column(
                children: [
                  Text(
                    items[index]['title'],
                    style: TextStyle(
                      color: grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    items[index]['description'],
                    style: TextStyle(
                      color: grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // Image
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      items[index]['img'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        );
      }),
      options: options,
    );
  }
}
