import 'package:flutter/material.dart';
import 'package:instagram/json/search_json.dart';
import 'package:instagram/theme/colors.dart';
import 'package:instagram/widgets/category.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView(
      children: [
        // Search Bar
        SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                width: size.width - 30,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: textFieldBackground,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefix: Icon(
                      Icons.search,
                      color: white.withOpacity(0.5),
                      size: 22,
                    ),
                  ),
                  style: TextStyle(
                    color: white.withOpacity(0.3),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Search Categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(searchCategories.length, (index) {
              return Category(name: searchCategories[index]);
            }),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Posts
        Wrap(
          spacing: 1,
          runSpacing: 1,
          children: List.generate(searchImages.length, (index) {
            return Container(
              width: (size.width - 3) / 3,
              height: (size.width - 3) / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    searchImages[index],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
