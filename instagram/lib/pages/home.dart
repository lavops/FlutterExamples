import 'package:flutter/material.dart';
import 'package:instagram/json/story_json.dart';
import 'package:instagram/theme/colors.dart';
import 'package:instagram/widgets/story.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Stories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Account Story
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                child: Column(
                  children: [
                    // Image with stack
                    Container(
                      width: 65,
                      height: 65,
                      child: Stack(
                        children: [
                          // Image
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(profile),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Plus Icon
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 19,
                              height: 19,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: white,
                              ),
                              child: Icon(
                                Icons.add_circle,
                                color: buttonFollowColor,
                                size: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Name
                    SizedBox(
                      width: 70,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
              ),
              // Other Stories
              Row(
                children: List.generate(stories.length, (index) {
                  return Story(
                    img: stories[index]['img'],
                    name: stories[index]['name'],
                  );
                }),
              )
            ],
          ),
        ),
        Divider(
          color: white.withOpacity(0.3),
        ),
        // Posts
      ],
    );
  }
}
