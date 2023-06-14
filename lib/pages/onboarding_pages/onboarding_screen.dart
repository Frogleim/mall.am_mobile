import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(controller: _controller, children: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.red,
          )
        ]),
        Container(
          alignment: Alignment(0, 0.8),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
          ),
        ),
      ]),
    );
  }
}
