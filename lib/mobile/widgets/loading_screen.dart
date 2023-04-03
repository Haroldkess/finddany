import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/service/constant.dart';
import '../screens/home/homeSplash.dart';
import '../screens/splashscreen.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 5)).whenComplete(() => {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
                print('User is currently signed out!');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Splash()),
            (route) => false);

      } else {
              print('User is signed in!');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeSplash()),
            (route) => false);

  
      }
    })
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Stack(alignment: Alignment.center, children: [
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
        const CupertinoActivityIndicator(
          color: Colors.white,
          radius: 30,
        )
      ]),
    );
  }
}
