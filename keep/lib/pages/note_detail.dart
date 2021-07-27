import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:keep/theme/colors.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final List images;

  NoteDetailPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.images})
      : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  List images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _title.text = widget.title;
      _description.text = widget.description;
      images = widget.images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomSheet: buildBottomBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 22,
          color: white.withOpacity(0.7),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            MaterialCommunityIcons.pin,
            size: 22,
            color: white.withOpacity(0.7),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            MaterialIcons.notifications,
            size: 22,
            color: white.withOpacity(0.7),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.archive,
            size: 22,
            color: white.withOpacity(0.7),
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget buildBody() {
    return ListView(
      padding: EdgeInsets.only(top: 25, bottom: 25, left: 15, right: 15),
      children: [
        // Title
        TextField(
          controller: _title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: white.withOpacity(0.8),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
        // Description
        TextField(
          maxLines: 10,
          controller: _description,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w400,
            color: white.withOpacity(0.8),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
        // Person Icons
        Row(
          children: List.generate(images.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: white.withOpacity(0.1),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  Widget buildBottomBar() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 50,
      decoration: BoxDecoration(color: bgColor, boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                AntDesign.plussquareo,
                size: 22,
                color: white.withOpacity(0.5),
              ),
            ),
            Text(
              "Edited Jul 27",
              style: TextStyle(
                fontSize: 12,
                color: white.withOpacity(0.7),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Octicons.kebab_vertical,
                size: 22,
                color: white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
