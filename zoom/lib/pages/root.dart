import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zoom/json/root_app_json.dart';
import 'package:zoom/pages/participant.dart';
import 'package:zoom/theme/colors.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: headerAndFooter,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Octicons.mute,
                color: grey,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                AntDesign.camera,
                color: grey,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.security_outlined, color: green, size: 15),
              SizedBox(
                width: 5,
              ),
              Text(
                "Zoom",
                style: TextStyle(
                    fontSize: 17, color: grey, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down, color: green, size: 15)
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: red, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
              child: Text(
                "Leave",
                style: TextStyle(
                    fontSize: 15, color: grey, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          color: headerAndFooter,
          border: Border(
              top: BorderSide(width: 2, color: black.withOpacity(0.06)))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomItems.length, (index) {
              return GestureDetector(
                onTap: () {
                  selectedTab(index);
                },
                child: Column(
                  children: [
                    Icon(bottomItems[index],
                        color: colorItems[index], size: sizedItems[index]),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      textItems[index],
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: colorItems[index]),
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              width: 120,
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(profileOtherURL), fit: BoxFit.cover)),
            ),
          ),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(profileMeURL), fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });

    if (pageIndex == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true, builder: (_) => ParticipantPage()));
    }
  }
}
