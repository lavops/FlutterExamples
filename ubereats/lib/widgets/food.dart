import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubereats/theme/colors.dart';

class FoodWidget extends StatelessWidget {
  final String img;
  final String name;
  final String description;
  final String time;
  final String fee;
  final bool isLiked;
  final String rate;
  final String rateNumber;
  final bool sponsored;
  final size;

  const FoodWidget(
      {Key? key,
      required this.img,
      required this.name,
      required this.description,
      required this.time,
      required this.fee,
      required this.isLiked,
      required this.rate,
      required this.rateNumber,
      required this.sponsored,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with heart
        Stack(
          children: [
            // Image
            GestureDetector(
              onTap: () {},
              child: Container(
                width: sponsored ? size.width - 30 : size.width,
                height: 160,
                child: Image(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Heart icon
            Positioned(
              bottom: 15,
              right: 15,
              child: SvgPicture.asset(
                isLiked
                    ? "assets/images/loved_icon.svg"
                    : "assets/images/love_icon.svg",
                width: 20,
                color: white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        // Food Store Name
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        // Sponsored
        if (sponsored)
          Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Sponsored",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Icon(
                    Icons.info,
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        SizedBox(
          height: 8,
        ),
        // Description
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        // Time to make and Delivery fee Or Rating
        Row(
          children: [
            // Hourglass Icon
            Container(
              decoration: BoxDecoration(
                color: textFieldColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
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
            // Time Text
            Container(
              decoration: BoxDecoration(
                color: textFieldColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            sponsored
                // Rating
                ? Container(
                    decoration: BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            rate,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.star,
                            color: yellowStar,
                            size: 17,
                          ),
                          Text(
                            rateNumber,
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
                :
                // Delivery Fee Text
                Container(
                    decoration: BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      fee,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
