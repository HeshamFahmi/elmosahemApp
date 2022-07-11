import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'change_phone_number_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "تسجيل الدخول برقم الموبايل",
                style: headingStyle,
              ),
              ChangePhoneNumberForm(),
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
            ],
          ),
        ),
      ),
    );
  }
}
