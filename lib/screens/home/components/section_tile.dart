import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionTile extends StatelessWidget {
  final String title;
  final GestureTapCallback press;
  final Widget screenName;
  const SectionTile({
    Key key,
    @required this.title,
    @required this.press,
    @required this.screenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(21),
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screenName),
              );
            },
            child: Text(
              "رؤية الكـل ->",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
