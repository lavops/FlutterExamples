import 'package:flutter/material.dart';
import 'package:messenger/theme/colors.dart';

class ProfileStack extends StatelessWidget {
  final isStory;
  final isOnline;
  final String profileImg;
  const ProfileStack(
      {Key? key,
      required this.isStory,
      required this.isOnline,
      required this.profileImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: Stack(
        children: [
          // Blue circle for having story
          isStory
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: blue_story,
                      width: 3,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(profileImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(profileImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          // Green dot for online
          isOnline
              ? Positioned(
                  top: 48,
                  left: 52,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: online,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: white,
                        width: 3,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
