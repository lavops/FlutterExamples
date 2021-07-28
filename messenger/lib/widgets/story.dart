import 'package:flutter/material.dart';
import 'package:messenger/theme/colors.dart';
import 'package:messenger/widgets/profile_stack.dart';

class Story extends StatelessWidget {
  final isStory;
  final isOnline;
  final String profileImg;
  final String name;
  const Story(
      {Key? key,
      required this.isStory,
      required this.isOnline,
      required this.profileImg,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            // Image with blue cirle and green dot
            ProfileStack(
                isStory: isStory, isOnline: isOnline, profileImg: profileImg),
            SizedBox(
              height: 10,
            ),
            // Name
            SizedBox(
              width: 75,
              child: Align(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
