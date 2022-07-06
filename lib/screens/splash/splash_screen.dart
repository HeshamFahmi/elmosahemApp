import 'package:elmosahem_app/screens/splash/components/bodyNew.dart';
import 'package:flutter/material.dart';
import 'package:elmosahem_app/size_config.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
