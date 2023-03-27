import 'package:flutter/material.dart';
import 'package:shoppingyou/service/constant.dart';

class LandingTablet extends StatelessWidget {
  const LandingTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 120.0,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent.withOpacity(0.5),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "1414",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Confirmed",
                  style: TextStyle(color: Colors.white54, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: 120.0,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent.withOpacity(0.5),
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "1217",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Paid",
                    style: TextStyle(color: Colors.white54, fontSize: 14.0),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: 120.0,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent.withOpacity(0.5),
                  child: Icon(
                    Icons.tv,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "75",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Ads",
                  style: TextStyle(color: Colors.white54, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
