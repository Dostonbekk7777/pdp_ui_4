import 'dart:ui';

import 'package:flutter/material.dart';

import 'Strings.dart';
import 'home_page.dart';

class IntroPage extends StatefulWidget {
  static final String id = 'intro_page';

  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _skipText() {
    if (currentIndex == 2) {
      return 'Skip';
    } else {
      return '';
    }
  }

  _skipFunction() {
    if (currentIndex == 2) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                onPageChanged: (int page) {
                  setState(() {
                    currentIndex = page;
                  });
                },
                controller: _pageController,
                children: [
                  makePage(
                      image: 'assets/images/image_1.png',
                      title: Strings.stepOneTitle,
                      content: Strings.stepOneContent),
                  makePage(
                      reverse: true,
                      image: 'assets/images/image_2.png',
                      title: Strings.stepTwoTitle,
                      content: Strings.stepTwoContent),
                  makePage(
                      image: 'assets/images/image_3.png',
                      title: Strings.stepThreeTitle,
                      content: Strings.stepThreeContent),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildIndicator()),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 60),
                        child: GestureDetector(
                          onTap: () {
                            _skipFunction();
                          },
                          child: Text(
                            '${_skipText()}',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget makePage({
    image,
    title,
    content,
    reverse = false,
  }) {
    return Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 60),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.red, fontSize: 34, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: TextStyle(color: Colors.grey, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          ),
        ]));
  }

  Widget _indicator(bool isActive) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 6,
          width: isActive ? 30 : 6,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
        ),
      ],
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
