import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:messenger/json/data.dart';
import 'package:messenger/theme/colors.dart';

class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: grey.withOpacity(0.2),
      elevation: 0,
      centerTitle: false,
      leading: FlatButton(
        onPressed: () {},
        child: Icon(
          Icons.arrow_back_ios,
          color: primary,
        ),
      ),
      title: Row(
        children: [
          // Image
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(profilePicture),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          // Name and Active Now
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tyler Nix",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: black),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Active now",
                style: TextStyle(
                  fontSize: 14,
                  color: black.withOpacity(0.4),
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        Icon(
          LineIcons.phone,
          color: primary,
          size: 32,
        ),
        SizedBox(
          width: 15,
        ),
        Icon(
          LineIcons.video,
          color: primary,
          size: 32,
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            color: online,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white38),
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
