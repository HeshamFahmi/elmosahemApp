import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import 'sign_up_form.dart';
import '../../../size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Text(
                "انشاء حساب",
                style: headingStyle,
              ),
              Text(
                "اكمل بياناتك او سجل باستخدام موقع تواصل اجتماعي",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.07),
              SignUpForm(),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                "بالاستمرار انت توافق علي الشروط والاحكام",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
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
            ],
          ),
        ),
      ),
    );
  }
}
