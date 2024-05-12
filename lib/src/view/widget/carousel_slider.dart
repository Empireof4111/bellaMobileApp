import 'package:bella_banga/src/utiliti/utility.dart';
import 'package:flutter/material.dart';
import 'package:bella_banga/core/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.38,
          child: PageView.builder(
            itemCount: widget.items.length,
            onPageChanged: (int currentIndex) {
              newIndex = currentIndex;
              setState(() {});
            },
            itemBuilder: (_, index) {
              return FittedBox(
                fit: BoxFit.contain,
                child: Image.network("$imageUrl${widget.items[index]}", scale: 3, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset("assets/images/errorImage.png");
        }),
              );
            },
          ),
        ),
        AnimatedSmoothIndicator(
          effect: const WormEffect(
            dotColor: Colors.white,
            activeDotColor: AppColor.darkOrange,
            dotHeight: 10,
            dotWidth: 10,
          ),
          count: widget.items.length,
          activeIndex: newIndex,
        )
      ],
    );
  }
}
