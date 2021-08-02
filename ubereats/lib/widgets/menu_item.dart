import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget(
      {Key? key,
      required this.size,
      required this.name,
      required this.description,
      required this.price,
      required this.image})
      : super(key: key);

  final Size size;
  final String name;
  final String description;
  final String price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          // Item name, desc, price
          Container(
            width: (size.width - 30) * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Desc
                Text(
                  description,
                  style: TextStyle(
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Price
                Text(
                  price,
                  style: TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          // Image
          Expanded(
            child: Container(
              height: 110,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: Image(
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
