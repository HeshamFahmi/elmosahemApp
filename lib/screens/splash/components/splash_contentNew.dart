import 'package:elmosahem_app/constants.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Spacer(flex: 2),
        Image.asset(image, fit: BoxFit.fill),
        Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: kPrimaryColor,
          ),
        )
      ],
    );
  }
}
