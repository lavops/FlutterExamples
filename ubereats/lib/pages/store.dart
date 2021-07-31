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
}
