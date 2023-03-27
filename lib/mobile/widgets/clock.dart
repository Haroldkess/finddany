// package to create analog clock

import 'package:flutter/material.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
// building the app widgets
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(right: Responsive.isDesktop(context) ?  onlyAllPadding * 2 : 5),
        child: Container(
          height: Responsive.isMobile(context) ? 65 :  100,
        //  width: 100,
          child:    DigitalClock(
                  digitAnimationStyle: Curves.elasticOut,
                  is24HourTimeFormat: false,
                  areaDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  hourMinuteDigitTextStyle: const TextStyle(
                    color: Color(0xff5956E9),
                    fontSize: 50,
                  ),
                  amPmDigitTextStyle: const  TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),              
                ),
        ),
      );
}
