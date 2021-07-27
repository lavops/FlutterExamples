import 'package:flutter/material.dart';
import 'package:keep/json/notes_json.dart';
import 'package:keep/theme/colors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.size,
    required GlobalKey<ScaffoldState> drawerKey,
  })  : _drawerKey = drawerKey,
        super(key: key);

  final Size size;
  final GlobalKey<ScaffoldState> _drawerKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: size.width,
        height: 45,
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Drawer, Search for notes
              Row(
                children: [
                  // Drawer button
                  GestureDetector(
                    onTap: () {
                      // Drawer
                      _drawerKey.currentState?.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search your notes",
                    style: TextStyle(
                      fontSize: 15,
                      color: white.withOpacity(0.7),
                    ),
                  )
                ],
              ),
              // Icon, Profile
              Row(
                children: [
                  // Drawer button
                  Icon(
                    Icons.grid_view,
                    color: white.withOpacity(0.7),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(profile_image_url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
