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
            ],
          ),
        ),
      ),
    );
  }
}
