import 'package:flutter/material.dart';
import 'package:shoppingyou/landingpage/SizeConfig.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier!),
          child: Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Text(
                      appName,
                      style: const TextStyle(
                          fontFamily: 'Raleway',
                          color: Color(0xff5956E9),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier!,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => MyApp()),
                        //     (route) => false);
                      },
                      child: Text(
                        "Home",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Raleway',
                          fontSize: 1 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier!,
                    ),

                    InkWell(
                      onTap: (){},
                      child: Text(
                        "Download App",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Raleway',
                          fontSize: 1 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ),
                    //   SizedBox(
                    //     width: 5 * SizeConfig.widthMultiplier!,
                    //   ),
                    //   GestureDetector(
                    // //    onTap: () => showToast('Not available for now'),
                    //     child: Text(
                    //       "Blog",
                    //       style: TextStyle(
                    //         color: kPrimaryColor,
                    //           fontFamily: 'Raleway',
                    //         fontSize: 1 * SizeConfig.textMultiplier!,
                    //       ),
                    //     ),
                    //   ),
                    SizedBox(
                      width: 5 * SizeConfig.widthMultiplier!,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Policy",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Raleway',
                          fontSize: 1 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ),

                    Spacer(),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 20.0,
                        // background color
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 1 * SizeConfig.textMultiplier!,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 1 * SizeConfig.textMultiplier!,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             RegisterationScreen()));
                      },
                    ),

                    // Icon(Icons.search, size: 3 * SizeConfig.imageSizeMultiplier!, color: Colors.white,),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      appName,
                      style: const TextStyle(
                          fontFamily: 'Raleway',
                          color: Color(0xff5956E9),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700),
                    ),

                    Spacer(),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 20.0,
                        // background color
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 1 * SizeConfig.textMultiplier!,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 1.5 * SizeConfig.textMultiplier!,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             RegisterationScreen()));
                      },
                    ),

                    // Icon(Icons.search, size: 3 * SizeConfig.imageSizeMultiplier!, color: Colors.white,),
                  ],
                ),
        ),
      ),
    );
  }
}
