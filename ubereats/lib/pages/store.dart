import 'package:flutter/material.dart';
import 'package:ubereats/theme/colors.dart';

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
            // Name
          ],
        ),
      ),
    );
  }
}
