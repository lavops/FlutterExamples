import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ubereats/pages/home.dart';
import 'package:ubereats/theme/colors.dart';

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
      body: buildBody(),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBody() {
    List<Widget> pages = [
      HomePage(),
      Center(
        child: Text(
          "Search Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Center(
        child: Text(
          "Grocery Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Center(
        child: Text(
          "Orders Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Center(
        child: Text(
          "Account Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      )
    ];

    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget buildBottomBar() {
    List bottomItems = [
      "assets/images/home_icon.svg",
      "assets/images/search_icon.svg",
      "assets/images/grocery_icon.svg",
      "assets/images/order_icon.svg",
      "assets/images/account_icon.svg"
    ];

    List textItems = ["Home", "Search", "Grocery", "Orders", "Account"];

    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: white,
        border: Border(
          top: BorderSide(
            width: 2,
            color: black.withOpacity(0.06),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
              onTap: () {
                changeTab(index);
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    bottomItems[index],
                    width: 22,
                    color: pageIndex == index ? black : Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textItems[index],
                    style: TextStyle(
                      fontSize: 10,
                      color: pageIndex == index ? black : Colors.grey,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  changeTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
