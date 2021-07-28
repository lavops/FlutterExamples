import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:messenger/json/data.dart';
import 'package:messenger/theme/colors.dart';
import 'package:messenger/widgets/chart_bubble.dart';

class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _sendMessageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomSheet: buildBottomBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: grey.withOpacity(0.2),
      elevation: 0,
      centerTitle: false,
      leading: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
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

  Widget buildBottomBar() {
    var size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: grey.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icons
            Container(
              width: (size.width - 40) / 2,
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.photo,
                    size: 35,
                    color: primary,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.keyboard_voice,
                    size: 35,
                    color: primary,
                  ),
                ],
              ),
            ),
            // TextBox and Like
            Container(
              width: (size.width - 40) / 2,
              child: Row(
                children: [
                  // TextBox
                  Container(
                    width: (size.width - 140) / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        cursorColor: black,
                        controller: _sendMessageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Aa",
                          suffixIcon: Icon(
                            Icons.face,
                            color: primary,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  // Like Icon
                  Icon(
                    Icons.thumb_up,
                    size: 35,
                    color: primary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        top: 20,
        bottom: 80,
      ),
      children: List.generate(messages.length, (index) {
        return ChatBubble(
          isMe: messages[index]['isMe'],
          profileImg: messages[index]['profileImg'],
          message: messages[index]['message'],
          messageType: messages[index]['messageType'],
        );
      }),
    );
  }
}
