import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ubereats/json/home_page_json.dart';
import 'package:ubereats/theme/colors.dart';
import 'package:ubereats/theme/styles.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;

    return ListView(
      children: [
        // Menu, Search Bar
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu ( Delivery, Pickup, Dine-in )
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                menu.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          activeMenu = index;
                        });
                      },
                      child: activeMenu == index
                          // Selected Menu
                          ? ElasticIn(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        menu[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          // Not selected menu
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      menu[index],
                                      style: customContent,
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Search bar and filter icon
            Row(
              children: [
                // Search bar
                Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 45,
                  width: size.width - 70,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Pin Icon and Text
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/pin_icon.svg",
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Kraljevo",
                              style: customContent,
                            ),
                          ],
                        ),
                      ),
                      // Now dropdown icon
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/time_icon.svg",
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Now",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Filter Icon
                Expanded(
                  child: Container(
                    child: SvgPicture.asset("assets/images/filter_icon.svg"),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        // Sliding Images
      ],
    );
  }
}
