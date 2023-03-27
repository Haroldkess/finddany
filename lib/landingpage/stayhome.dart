

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingyou/landingpage/landing_desktop.dart';
import 'package:shoppingyou/landingpage/landing_header.dart';
import 'package:shoppingyou/landingpage/landing_mobile.dart';
import 'package:shoppingyou/landingpage/landing_tablet.dart';
import 'package:shoppingyou/landingpage/socialmedia.dart';
import 'package:shoppingyou/service/constant.dart';



import '../responsive/responsive_config.dart';
import 'SizeConfig.dart';

// class LandHere extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   _LandHereState createState() => _LandHereState();
// }

// class _LandHereState extends State<LandHere> {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return LayoutBuilder(builder: (context, constraints) {
//       return OrientationBuilder(builder: (context, orientation) {
//         SizeConfig().init(constraints, orientation);
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'ShopYou',
//           theme: ThemeData(
//             primarySwatch: Colors.purple,
//           ),
//           home: StayHome(),
//         );
//       });
//     });
//   }
// }

String? link;

class StayHome extends StatefulWidget {
  const StayHome({Key? key}) : super(key: key);

  @override
  State<StayHome> createState() => _StayHomeState();
}

class _StayHomeState extends State<StayHome> {
   List<Color> _colors = [Colors.white, Color(0xff6034a7)];

  // void showToast(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 5,
  //     backgroundColor: kPrimaryColor,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
     ]);
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _colors,
                stops: [0.4, 0.7]),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Stack(
                children: [
                     Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(left: Responsive.isDesktop(context) ?  250 : 100),
                child: const Image(image: AssetImage('assets/images/EllipseMorado.png')),
              ),
              ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.center,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: const Image(
                      image: AssetImage('assets/images/EllipseRosa.png'),
                      fit: BoxFit.contain)),
            ],
          ),
        
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        children: [
                          LandingHeader(),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.48,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Responsive.isDesktop(context)
                                                ?  Row(
                                                  children: [
                                                    Text(
                                                        "$appName \nEarn from home",
                                                        style: TextStyle(
                                                            color:  Colors.blue.shade900,
                                                              fontFamily: 'Raleway',
                                                            fontSize: 40.0,
                                                            fontWeight:
                                                                FontWeight.w900),
                                                      ),
                                                        const Padding(
                padding:  EdgeInsets.only(left:  5),
                child:  Image(
                  height: 100,
                 // width: 50,
                  image: AssetImage('assets/images/no_favorites.png')),
              ),
                                                  ],
                                                )
                                                : const SizedBox.shrink(),
                                            Responsive.isDesktop(context)
                                                ? const SizedBox(
                                                    height: 20.0,
                                                  )
                                                : SizedBox.shrink(),
                                            const Text(
                                              "Grow your business and earn.  \nFast and Secure payments",
                                              style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                color: kPrimaryColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 50.0,
                                            ),
                                            const Text(
                                              "Highly trusted and Reliable",
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontFamily: 'Raleway',
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            const Text(
                                              "Lets show your products to the world ",
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontFamily: 'Raleway',
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 50.0,
                                            ),
                                            const Responsive(
                                                mobile: LandingMobile(),
                                                desktop: LandingDesktop(),
                                                tablet: LandingTablet())
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                    alignment: Responsive.isDesktop(context)
                                        ? Alignment.bottomRight
                                        : Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: Responsive.isDesktop(context)
                                              ? 2.0
                                              : 0.5,
                                          left: Responsive.isDesktop(context)
                                              ? 10.0
                                              : 3.0),
                                      child: Responsive.isDesktop(context)
                                          ? Image.asset(
                                              "assets/images/splash.png")
                                          : Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.2,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/images/splash.png",
                                                      ),
                                                      fit: BoxFit.contain)),
                                            ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(bottom: 50.0, right: 30.0, child: SocialMedia())
                ],
              ),
            ),
          ),
        );
      });
    });
 
    
  }
}

//https://image.flaticon.com/icons/svg/2659/2659980.svg
