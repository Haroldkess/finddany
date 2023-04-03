import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../responsive/responsive_config.dart';
import 'clock.dart';

class AnimatedLargeHeader extends StatefulWidget {
  const AnimatedLargeHeader({Key? key}) : super(key: key);

  @override
  State<AnimatedLargeHeader> createState() => _AnimatedLargeHeaderState();
}

class _AnimatedLargeHeaderState extends State<AnimatedLargeHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(right: 10, top: 0.0, left: 15),
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  context.watch<UiProvider>().name.isEmpty
                      ? RotateAnimatedText(
                          'Hello!',
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          //speed: const Duration(milliseconds: 200),
                        )
                      : RotateAnimatedText(
                          context.watch<UiProvider>().name,
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          //    speed: const Duration(milliseconds: 200),
                        ),
                  RotateAnimatedText(
                    'Get All You Need!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                    ),
                    //   speed: const Duration(milliseconds: 200),
                  ),
                  RotateAnimatedText(
                    'At The Best Price!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                    ),
                    //speed: const Duration(milliseconds: 200),
                  ),
                  RotateAnimatedText(
                    'Here At $appName',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                      color: Color(0xff5956E9),
                    ),
                    //  speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                repeatForever: true,
                stopPauseOnTap: true,
              ),
            ),

            //  Text(
            //   'Order online collect in store',
            //   style: TextStyle(
            //       fontFamily: 'Raleway',
            //       fontSize: 34.0,
            //       fontWeight: FontWeight.w700),
            // ),
          ),
        ),
        Clock()
      ],
    );
  }
}

class AnimatedSmall extends StatefulWidget {
  const AnimatedSmall({Key? key}) : super(key: key);

  @override
  State<AnimatedSmall> createState() => _AnimatedSmallState();
}

class _AnimatedSmallState extends State<AnimatedSmall> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Responsive.isMobile(context) ? 50 : 50,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, left: 10),
              child: AnimatedTextKit(
                animatedTexts: [
                  context.watch<UiProvider>().name.isEmpty
                      ? RotateAnimatedText(
                          'Hello!',
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          //speed: const Duration(milliseconds: 200),
                        )
                      : RotateAnimatedText(
                          context.watch<UiProvider>().name,
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          //    speed: const Duration(milliseconds: 200),
                        ),
                  RotateAnimatedText(
                    'Get All You Need!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                    ),
                    // speed: const Duration(milliseconds: 200),
                  ),
                  RotateAnimatedText(
                    'At The Best Price!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                    ),
                    //speed: const Duration(milliseconds: 200),
                  ),
                  RotateAnimatedText(
                    'Here At $appName!',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                      color: Color(0xff5956E9),
                    ),
                    //    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                repeatForever: true,
                stopPauseOnTap: true,
              ),

              //  Text(
              //   'Order online collect in store',
              //   style: TextStyle(
              //       fontFamily: 'Raleway',
              //       fontSize: 34.0,
              //       fontWeight: FontWeight.w700),
              // ),
            ),
          ),
        ),
        Clock()
      ],
    );
  }
}
