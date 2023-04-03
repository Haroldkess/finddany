import 'package:align_positioned/align_positioned.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/screens/splashscreen.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../../models/user_model.dart';
import '../../../service/database_service.dart';
import '../../widgets/drawer.dart';
import 'homescreen.dart';

class HomeSplash extends StatefulWidget {
  const HomeSplash({Key? key}) : super(key: key);

  @override
  State<HomeSplash> createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  SharedPreferences? pref;

  String image =
      'https://img.freepik.com/free-photo/satisfied-carefree-female-model-smiles-gently-touches-chin-looks-aside-notices-funny-scene-laughs-something-has-natural-curly-dark-hair-dressed-casually-isolated-pink-wall_273609-27918.jpg?w=2000';
  final List<dynamic> _contacts = [
    {
      'name': 'Shoe',
      'avatar':
          'assets/images/splash.png',
    },
    {
      'name': 'Shirt',
      'avatar':
          'assets/images/no_favorites.png',
    },
    {
      'name': 'bURGER',
      'avatar':
          'assets/images/no_history.png',
    },
    {
      'name': 'game',
      'avatar':
          'assets/images/avatar.png',
    },
    {
      'name': 'headset',
      'avatar':
          'assets/images/itemnotfound.png',
    },
    {
      'name': 'pepsi',
      'avatar':
          'assets/images/no_connection.png',
    }
  ];
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 5)).whenComplete(() async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          print('User is currently signed out!');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Splash()),
              (route) => false);
        } else {
          print('User is signed in!');
          await callApis(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AppDrawer(child: Home())),
              (route) => false);
        }
      });
    });
  }

  Future<void> callApis(context) async {
    await Controls.getHomeProduct(context, false);
    await Controls.getQuickPicksProduct(context);
    await Controls.getSliderProduct(context);
    await Controls.getPopularProduct(context);
    await Controls.getJustForYouProduct(context);
    await Controls.getCategory(context);
   
  

    await saveInfo(context);
    //await Future.delayed(const Duration(seconds: 3));
    //  Navigator.pushReplacementNamed(context, 'home');
  }

  Future<void> saveInfo(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserModel user = await DatabaseService.getUserWithId();

    await pref.setStringList(notificationKey, ['Welcome to $appName']);

    await pref.setString(userIdKey, user.id!);
    await pref.setString(nameKey, user.name!);

    await pref.setString(emailKey, user.email!);

    await pref.setString(
        dpKey,
        user.profileImageUrl == null || user.profileImageUrl!.isEmpty
            ? "null"
            : user.profileImageUrl!);
    await pref.setString(
        addressKey,
        user.userLocation == null || user.userLocation!.isEmpty
            ? "null"
            : user.userLocation!);
    await pref.setBool(
        hasShopKey, user.hasShop == null ? false : user.hasShop!);
    await pref.setString(countryKey,
        user.country == null || user.country!.isEmpty ? "null" : user.country!);
    await pref.setString(stateKey,
        user.state == null || user.state!.isEmpty ? "null" : user.state!);
    await pref.setString(
        phoneKey,
        user.phoneNumber == null || user.phoneNumber!.isEmpty
            ? "null"
            : user.phoneNumber!);
    await Provider.of<UiProvider>(context, listen: false)
        .addUserName(pref.getString(nameKey)!);
    await Provider.of<UiProvider>(context, listen: false)
        .addAdress(pref.getString(addressKey)!);
    await Provider.of<UiProvider>(context, listen: false)
        .addPhone(pref.getString(phoneKey)!);
            await Provider.of<UiProvider>(context, listen: false)
        .addHasShop(pref.getBool(hasShopKey)!);
                    await Provider.of<UiProvider>(context, listen: false)
        .addMail(pref.getString(emailKey)!);

         await Provider.of<UiProvider>(context, listen: false)
        .addDp(pref.getString(dpKey)!);
    print('done getting some user info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue.shade900,
      body: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Image(image: AssetImage('assets/images/EllipseMorado.png')),
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
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children:  const [
                  // FadeInUp(
                  //   duration: Duration(milliseconds: 500),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 300,
                  //     padding: EdgeInsets.all(90.0),
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.blue.shade900,
                  //       border:
                  //           Border.all(color: Colors.blue.shade900, width: 2.0),
                  //     ),
                  //     child: Stack(
                  //       children: [
                  //         for (double i = 0; i < 360; i += 60)
                  //           AnimChain(
                  //                   initialDelay:
                  //                       Duration(milliseconds: i.toInt()))
                  //               .next(
                  //                 wait: Duration(milliseconds: 1000),
                  //                 widget: AnimatedAlignPositioned(
                  //                   dx: 0,
                  //                   dy: 150,
                  //                   duration: Duration(seconds: 1),
                  //                   rotateDegrees: 0,
                  //                   touch: Touch.middle,
                  //                   child: user(0, i),
                  //                 ),
                  //               )
                  //               .next(
                  //                 wait: Duration(seconds: 2),
                  //                 widget: AnimatedAlignPositioned(
                  //                   dx: i / 560,
                  //                   dy: 150,
                  //                   duration: Duration(seconds: 1),
                  //                   rotateDegrees: i,
                  //                   touch: Touch.middle,
                  //                   child: user(0, i),
                  //                 ),
                  //               ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  
                  
                   Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const  [
                   Text(
                    'Findd ',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700),
                  ),
                   Text(
                    'Any ',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.red,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700),
                  ),
        
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  user(int index, double number) {
    index = number ~/ 60;
    return FadeInRight(
      delay: Duration(seconds: 1),
      duration: Duration(milliseconds: (index * 100) + 500),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: number / 60 * 5.2,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade900,
                  backgroundImage:
                      AssetImage(_contacts[index]['avatar']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
