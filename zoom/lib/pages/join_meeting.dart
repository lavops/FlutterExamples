import 'package:flutter/material.dart';
import 'package:zoom/pages/root.dart';
import 'package:zoom/theme/colors.dart';

class JoinMeetingPage extends StatefulWidget {
  @override
  _JoinMeetingPageState createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  bool isAudioSwitch = true;
  bool isVideoSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: headerAndFooter,
        appBar: buildAppBar(),
        body: buildBody());
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: headerAndFooter,
      elevation: 0,
      centerTitle: true, // default false
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Close",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      title: Text(
        "Join a Meeting",
      ),
    );
  }

  Widget buildBody() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        // Meeting ID
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(color: grey.withOpacity(0.03)),
          child: Row(
            children: [
              Container(
                width: size.width * 0.3,
                height: 40,
              ),
              Container(
                width: size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: TextField(
                    cursorColor: primary,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Meeting ID",
                      hintStyle: TextStyle(color: grey.withOpacity(0.3)),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        color: grey,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Blue text personal link name
        Text(
          "Join with a personal link name",
          style: TextStyle(color: primary),
        ),
        SizedBox(
          height: 15,
        ),
        // Screen Name
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(color: grey.withOpacity(0.03)),
          child: Row(
            children: [
              Container(
                width: size.width * 0.3,
              ),
              Container(
                width: size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: TextField(
                    cursorColor: primary,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Screen Name",
                      hintStyle: TextStyle(color: grey.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Join
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => Root()), (route) => false);
          },
          child: Container(
            width: size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Join",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Text
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            "If you received an invitation link, tap on the link again to join the meeting",
            style: TextStyle(
              color: grey.withOpacity(0.6),
              height: 1.3,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        // Switch 1
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.03),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Don't Connect To Audio",
                  style: TextStyle(
                    fontSize: 15,
                    color: grey,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  activeColor: primary,
                  value: isAudioSwitch,
                  onChanged: (value) {
                    setState(() {
                      isAudioSwitch = value;
                    });
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Switch 2
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.03),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Turn Off My Video",
                  style: TextStyle(
                    fontSize: 15,
                    color: grey,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  activeColor: primary,
                  value: isVideoSwitch,
                  onChanged: (value) {
                    setState(() {
                      isVideoSwitch = value;
                    });
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
