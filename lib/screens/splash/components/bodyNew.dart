import 'package:elmosahem_app/screens/sign_up/sign_up_screen.dart';
import 'package:elmosahem_app/screens/sign_up_withPhone/signUpWithPhone.dart';
import 'package:elmosahem_app/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:elmosahem_app/constants.dart';
import 'package:elmosahem_app/screens/sign_in/sign_in_screen.dart';
import 'package:elmosahem_app/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

// This is the best practice
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  var aboutApp;

  getAbout() async {
    aboutApp = await UserDatabaseHelper().aboutAppString();
    //print(aboutApp);
  }

  @override
  void initState() {
    getAbout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   "assets/images/launcher_icon_trans.png",
              //   width: double.infinity,
              //   height: 300,
              // ),
              Text(
                "مرحبـا بــك",
                style: headingStyle,
              ),
              SizedBox(height: 20),
              Text(
                "يمكنـك تسجيــل الدخول باستخدام كل مــن",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SizedBox(height: 20),
              DefaultButton(
                icon: Icons.phonelink_setup_sharp,
                color: kPrimaryLightColor,
                text: "الموبايل",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupWithPhone()),
                  );
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              DefaultButton(
                icon: Icons.email,
                color: kPrimaryLightColor,
                text: "البريد الالكترونى",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 2,
              ),
              Text(
                "او يمكنك انشــاء حساب من خلال ",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(20),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SizedBox(height: 20),
              DefaultButton(
                icon: Icons.verified_user,
                color: kSecondaryColor,
                text: "انشاء حساب",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "او يمكنك استخـدام مواقع التواصل الاجتماعى التاليــه ",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: SvgPicture.asset("assets/icons/facebook-2.svg",
                            width: 50, height: 50),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                            height: 1.5,
                            fontSize: getProportionateScreenHeight(40),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: SvgPicture.asset("assets/icons/google-icon.svg",
                            width: 50, height: 50),
                      )
                    ],
                  )),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 250,
                          color: kSecondaryColor.withOpacity(0.1),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    aboutApp,
                                    style: headingStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text(
                  " اعرف نبـذه عــن المســاهــم !!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: kPrimaryColor),
                ),
              )
            ],
          ),
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
