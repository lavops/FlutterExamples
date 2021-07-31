import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ubereats/json/home_page_json.dart';
import 'package:ubereats/theme/colors.dart';
import 'package:ubereats/theme/styles.dart';

class StorePage extends StatefulWidget {
  final String img;
  final String name;
  final String description;
  final String time;
  final String fee;
  final bool isLiked;
  final String rate;
  final String rateNumber;

  StorePage(
      {Key? key,
      required this.img,
      required this.name,
      required this.description,
      required this.time,
      required this.fee,
      required this.isLiked,
      required this.rate,
      required this.rateNumber})
      : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomSheet: buildBottomSheet(),
      body: buildBody(),
    );
  }

  Widget buildBottomSheet() {
    var size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
        color: white,
        border: Border(
          top: BorderSide(
            color: black.withOpacity(0.1),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Text(
              "\$15.00 away from a \$0.00 delivery fee",
              style: TextStyle(
                color: primary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            // Image with Icons
            Stack(
              children: [
                // Image
                Container(
                  width: size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Icons
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Icon
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      // Liked
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              widget.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // Food Description
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Description
                  Row(
                    children: [
                      Container(
                        width: size.width - 30,
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Time and Rating
                  Container(
                    child: Row(
                      children: [
                        // Hourglass Icon
                        Container(
                          decoration: BoxDecoration(
                            color: textFieldColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.hourglass_bottom,
                              color: primary,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // Time
                        Container(
                          decoration: BoxDecoration(
                            color: textFieldColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              widget.time,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // Rating
                        Container(
                          decoration: BoxDecoration(
                            color: textFieldColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                // Rate
                                Text(
                                  widget.rate,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                // Star Icon
                                Icon(
                                  Icons.star,
                                  color: primary,
                                  size: 17,
                                ),
                                // Number of ratings
                                Text(
                                  "(" + widget.rateNumber + ")",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: black.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Store Info
                  Text(
                    "Store Info",
                    style: customContent,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Location and more info
                  Row(
                    children: [
                      // Location
                      Container(
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            // Pin Icon
                            SvgPicture.asset(
                              "assets/images/pin_icon.svg",
                              width: 15,
                              color: black.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            // Location Text
                            Text(
                              "Kraljevo, Cara Dusana",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      // More Info
                      Expanded(
                        child: Text(
                          "More Info",
                          style: TextStyle(
                            fontSize: 14,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // People say
                  Row(
                    children: [
                      // Comment icon
                      Icon(
                        LineIcons.comment,
                        size: 15,
                        color: primary,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      // People say text
                      Text(
                        "People say...",
                        style: TextStyle(
                          fontSize: 14,
                          color: black.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Reviews
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(peopleFeedback.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  peopleFeedback[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Delivery Fee
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
