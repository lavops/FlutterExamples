import 'package:flutter/material.dart';
import 'package:keep/json/sidemenu_icon_json.dart';
import 'package:keep/theme/colors.dart';

class SideMenuPage extends StatefulWidget {
  @override
  _SideMenuPageState createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
        ),
        child: SafeArea(
          child: ListView(
            children: [
              header(),
              // Notes, Reminders
              sectionOne(),
              // Labels
              sectionTwo(),
              // Archive, Trash
              sectionThree(),
              // Settings, Feedback, Help
              sectionFour(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: white.withOpacity(0.1),
          ),
        ),
      ),
      child: DrawerHeader(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 30),
          child: Text(
            "Google Keep",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: white,
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionOne() {
    return Column(
      children: [
        Column(
          children: List.generate(2, (index) {
            return FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context, route);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25),
                child: Row(
                  children: [
                    Icon(
                      sideMenuItem[index]['icon'],
                      color: white.withOpacity(0.7),
                      size: 22,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      sideMenuItem[index]['text'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: white.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child: Divider(
            thickness: 1,
            color: white.withOpacity(0.1),
          ),
        )
      ],
    );
  }

  Widget sectionTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 15),
          child: Text(
            "LABELS",
            style: TextStyle(fontSize: 12, color: white.withOpacity(0.7)),
          ),
        ),
        Column(
          children: List.generate(5, (index) {
            return FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context, route);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25),
                child: Row(
                  children: [
                    Icon(
                      sideMenuItem[index + 2]['icon'],
                      color: white.withOpacity(0.7),
                      size: 22,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      sideMenuItem[index + 2]['text'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: white.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child: Divider(
            thickness: 1,
            color: white.withOpacity(0.1),
          ),
        )
      ],
    );
  }

  Widget sectionThree() {
    return Column(
      children: [
        Column(
          children: List.generate(2, (index) {
            return FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context, route);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25),
                child: Row(
                  children: [
                    Icon(
                      sideMenuItem[index + 7]['icon'],
                      color: white.withOpacity(0.7),
                      size: 22,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      sideMenuItem[index + 7]['text'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: white.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child: Divider(
            thickness: 1,
            color: white.withOpacity(0.1),
          ),
        )
      ],
    );
  }

  Widget sectionFour() {
    return Column(
      children: [
        Column(
          children: List.generate(3, (index) {
            return FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context, route);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25),
                child: Row(
                  children: [
                    Icon(
                      sideMenuItem[index + 9]['icon'],
                      color: white.withOpacity(0.7),
                      size: 22,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      sideMenuItem[index + 9]['text'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: white.withOpacity(0.7),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child: Divider(
            thickness: 1,
            color: white.withOpacity(0.1),
          ),
        )
      ],
    );
  }
}
