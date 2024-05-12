import 'package:bella_banga/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = "/OnbordingScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            Center(
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/choose-product.png",
                    width: 250,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Choose product",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkOrange),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Find your best product from \nour classic product without any delay",
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/make-payment.png",
                    width: 250,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Make Payment",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkOrange),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "There are may payment options \nfor ease",
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/get-order.png",
                    width: 250,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Get Your Order",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkOrange),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your product dispatch withing 1-2 Business \nday. Delivery at your doorstep",
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),

        //page view ends
        Container(
            alignment: const Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // skip
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          color: AppColor.darkOrange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const SlideEffect(
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        dotColor: Colors.grey,
                        activeDotColor: AppColor.darkOrange),
                  ),
                  onLastPage
                      ? GestureDetector(
                          onTap: () async {
                           final SharedPreferences pref = await SharedPreferences.getInstance();
                           pref.setBool('ON_BOARDING', false);
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false );
                          },
                          child: const Text(
                            "Done",
                            style: TextStyle(
                                color: AppColor.darkOrange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: AppColor.darkOrange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                  //next
                ],
              ),
            ))
      ],
    ));
  }
}
