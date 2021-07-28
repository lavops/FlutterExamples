import 'package:flutter/material.dart';
import 'package:messenger/theme/colors.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  const ChatBubble(
      {Key? key,
      required this.isMe,
      required this.profileImg,
      required this.message,
      required this.messageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: messageTypeBR(messageType),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(profileImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: messageTypeBR(messageType),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  messageTypeBR(messageType) {
    if (isMe) {
      // Start message
      if (messageType == 1) {
        return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      }
      // Middle message
      else if (messageType == 2) {
        return BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      }
      // End message
      else if (messageType == 3) {
        return BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        );
      }
      // Single message
      else {
        return BorderRadius.all(Radius.circular(30));
      }
    }
    // Other person
    else {
      // Start message
      if (messageType == 1) {
        return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(5),
        );
      }
      // Middle message
      else if (messageType == 2) {
        return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        );
      }
      // End message
      else if (messageType == 3) {
        return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(30),
        );
      }
      // Single message
      else {
        return BorderRadius.all(Radius.circular(30));
      }
    }
  }
}
