import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:messenger/json/data.dart';
import 'package:messenger/theme/colors.dart';
import 'package:messenger/widgets/profile_stack.dart';
import 'package:messenger/widgets/story.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
        ),
        children: [
          // AppBar
          buildAppBar(),
          SizedBox(
            height: 10,
          ),
          // Search box
          buildSearchBox(),
          SizedBox(
            height: 30,
          ),
          // Stories
          buildStories(),
          SizedBox(
            height: 30,
          ),
          // Chat History
          buildChatHistory(),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
        Text(
          "Chats",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(Icons.edit),
      ],
    );
  }

  Widget buildSearchBox() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorColor: black,
        controller: _searchControler,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: black.withOpacity(0.5),
          ),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildStories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Your Story
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: grey,
                  ),
                  child: Icon(
                    LineIcons.plus,
                    size: 33,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 75,
                  child: Align(
                    child: Text(
                      "Your Story",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Other Stories
          Row(
            children: List.generate(userStories.length, (index) {
              return Story(
                  isStory: userStories[index]['story'],
                  isOnline: userStories[index]['online'],
                  profileImg: userStories[index]['img'],
                  name: userStories[index]['name']);
            }),
          )
        ],
      ),
    );
  }

  Widget buildChatHistory() {
    var size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(userMessages.length, (index) {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                // Image
                ProfileStack(
                  isStory: userMessages[index]['story'],
                  isOnline: userMessages[index]['online'],
                  profileImg: userMessages[index]['img'],
                ),
                SizedBox(
                  width: 20,
                ),
                // Name and recent message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      userMessages[index]['name'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Recent message
                    SizedBox(
                      width: size.width - 135,
                      child: Text(
                        userMessages[index]['message'] +
                            " - " +
                            userMessages[index]['created_at'],
                        style: TextStyle(
                          fontSize: 15,
                          color: black.withOpacity(0.8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
