import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/class/my_shared_preferences.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/screens/sign_in/sign_in_screen.dart';
import 'package:tim_phong_tro/screens/splash/components/splash_content.dart';
import 'package:tim_phong_tro/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  bool isVisible = false;
  List<Map<String, String>> splashData = [
    {"text": "Welcome to Tokyo", "image": "assets/images/splash_1.png"},
    {
      "text": "We help people connect with store \nAround the world",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop",
      "image": "assets/images/splash_3.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                  if (currentPage == splashData.length - 1 &&
                      isVisible == false) {
                    setState(() {
                      isVisible = true;
                    });
                  }
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]["text"]!,
                  image: splashData[index]["image"]!,
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      AnimatedOpacity(
                        opacity: isVisible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 200),
                        child: DefaultButton(
                          text: "Continue",
                          press: () async {
                            await MysharedPreferences.instance
                                .setBooleanValue("secondTimeOpen", true);
                            Navigator.pushReplacementNamed(
                                context, SignInScreen.routeName);
                          },
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
