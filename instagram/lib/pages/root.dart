import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/pages/home.dart';
import 'package:instagram/theme/colors.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: buildAppBar(),
        bottomNavigationBar: buildBottomBar(),
        body: buildBody());
  }

  AppBar? buildAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/images/camera_icon.svg",
              width: 30,
            ),
            Text(
              "Instagram",
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 35,
              ),
            ),
            SvgPicture.asset(
              "assets/images/message_icon.svg",
              width: 30,
            ),
          ],
        ),
      );
    } else if (pageIndex == 1) {
      return null;
    } else if (pageIndex == 2) {
      return AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text("Upload"),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text("Activity"),
      );
    } else if (pageIndex == 4) {
      return AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text("Account"),
      );
    }
  }

  Widget buildBottomBar() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/home_active_icon.svg"
          : "assets/images/home_icon.svg",
      pageIndex == 1
          ? "assets/images/search_active_icon.svg"
          : "assets/images/search_icon.svg",
      pageIndex == 2
          ? "assets/images/upload_active_icon.svg"
          : "assets/images/upload_icon.svg",
      pageIndex == 3
          ? "assets/images/love_active_icon.svg"
          : "assets/images/love_icon.svg",
      pageIndex == 4
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: appFooterColor,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: SvgPicture.asset(
                bottomItems[index],
                width: 27,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildBody() {
    List<Widget> pages = [
      HomePage(),
      Center(
        child: Text(
          "Upload Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
      ),
      Center(
        child: Text(
          "Activity Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
      ),
      Center(
        child: Text(
          "Account Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
      )
    ];

    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }
}
