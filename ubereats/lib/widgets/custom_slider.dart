import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ubereats/theme/colors.dart';

class CustomSliderWidget extends StatefulWidget {
  final List items;

  CustomSliderWidget({Key? key, required this.items}) : super(key: key);

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  int activeIndex = 0;

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      overflow: Overflow.visible,
      children: [
        // Image
        Container(
          width: size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setActiveDot(index);
              },
              enableInfiniteScroll: false,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: Duration(seconds: 2),
              viewportFraction: 1.0,
            ),
            items: widget.items.map(
              (item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Container(
                          width: size.width,
                          child: Image(
                            image: AssetImage(item),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
        // Active and non-active dots
        Positioned(
          left: 20,
          right: 0,
          bottom: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.items.length, (index) {
              return activeIndex == index
                  ? ActiveDotWidget()
                  : NonActiveDotWidget();
            }),
          ),
        )
      ],
    );
  }
}

class ActiveDotWidget extends StatelessWidget {
  const ActiveDotWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class NonActiveDotWidget extends StatelessWidget {
  const NonActiveDotWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
