import 'package:flutter/material.dart';
import 'package:keep/json/sidemenu_icon_json.dart';
import 'package:keep/pages/home.dart';
import 'package:keep/pages/sidemenu_detail.dart';
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
              section(2, 0),
              // Labels
              section(5, 2),
              // Archive, Trash
              section(2, 7),
              // Settings, Feedback, Help
              section(3, 9),
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

  Widget section(int length, int startPoint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LABELS Title if it is section two
        startPoint == 2
            ? Padding(
                padding: const EdgeInsets.only(left: 25, top: 15),
                child: Text(
                  "LABELS",
                  style: TextStyle(fontSize: 12, color: white.withOpacity(0.7)),
                ),
              )
            : SizedBox(),
        // Icon and Text
        Column(
          children: List.generate(length, (index) {
            return FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (index + startPoint == 0) {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                      (route) => false);
                } else {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SideMenuDetailPage(
                          title: sideMenuItem[index + startPoint]['text']),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25),
                child: Row(
                  children: [
                    Icon(
                      sideMenuItem[index + startPoint]['icon'],
                      color: white.withOpacity(0.7),
                      size: 22,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      sideMenuItem[index + startPoint]['text'],
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
