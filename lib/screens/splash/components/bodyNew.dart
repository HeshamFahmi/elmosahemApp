import 'package:elmosahem_app/screens/sign_up/sign_up_screen.dart';
import 'package:elmosahem_app/screens/sign_up_withPhone/signUpWithPhone.dart';
import 'package:elmosahem_app/screens/splash/components/splash_contentNew.dart';
import 'package:flutter/material.dart';
import 'package:elmosahem_app/constants.dart';
import 'package:elmosahem_app/screens/sign_in/sign_in_screen.dart';
import 'package:elmosahem_app/size_config.dart';

// This is the best practice
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": " \n اهلا بك في تطبيق المساهم", "image": "assets/images/logo.png"},
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
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
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
                    Spacer(flex: 1),
                    DefaultButton(
                      color: kPrimaryColor,
                      text: "تسجيل الدخول باستخدام الايميل",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefaultButton(
                      color: kPrimaryColor,
                      text: "تسجيل الدخول باستخدام الموبايل",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupWithPhone()),
                        );
                      },
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    DefaultButton(
                      color: kSecondaryColor,
                      text: "انشاء حساب",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFF8CC8D2),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
