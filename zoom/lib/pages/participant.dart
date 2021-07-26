import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zoom/json/participants_json.dart';
import 'package:zoom/theme/colors.dart';

class ParticipantPage extends StatefulWidget {
  @override
  _ParticipantPageState createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerAndFooter,
      appBar: buildAppBar(),
      bottomSheet: buildBottomSheet(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    var participantsCount = participants.length;

    return AppBar(
      elevation: 0,
      centerTitle: true, // Kod androida je ovo po defaultu false
      backgroundColor: headerAndFooter,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Close",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      title: Text("Participants ($participantsCount)"),
    );
  }

  Widget buildBottomSheet() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(color: black),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: headerAndFooter),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Invite",
                  style: TextStyle(
                      color: grey, fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 70),
          child: Column(
            children: List.generate(participants.length, (index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        participants[index]['img']),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              participants[index]['name'],
                              style: TextStyle(
                                  color: grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              MaterialCommunityIcons.microphone,
                              color: grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              index == 0
                                  ? MaterialCommunityIcons.video
                                  : MaterialCommunityIcons.video_off,
                              color: index == 0 ? grey : red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(color: grey.withOpacity(0.08))
                ],
              );
            }),
          )),
    );
  }
}
