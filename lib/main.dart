import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/loading_screen.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/state/fuel_manager.dart';
import 'package:shoppingyou/state/ui_manager.dart';

import 'mobile/routes/routes.dart';
import 'mobile/screens/homeSplash.dart';
import 'mobile/screens/homescreen.dart';
import 'mobile/screens/splashscreen.dart';
import 'mobile/widgets/drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: 'AIzaSyDTuLm2CKHeLZ2O-6gpjMltwPzWatdG0wI',
              appId: '1:693568913009:web:3db7b370bd7afeca0e25d0',
              messagingSenderId: '693568913009',
              projectId: 'shopingyou-64e8e',
              storageBucket: 'shopingyou-64e8e.appspot.com',
            )
          : null);
      
      
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  // Widget _getScreenId() {
  //   log('Let us check if the user is already logged in');

  //   return StreamBuilder<User?>(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: (BuildContext context, snapshot) {
  //       UiProvider _provider = Provider.of<UiProvider>(context);
  //       _provider.initializePref();

  //       // if (snapshot.connectionState == ConnectionState.active) {
  //         if (snapshot.hasData) {
  //           _provider.getPref.setString(userIdKey, snapshot.data!.uid);              
  //           return const HomeSplash();
  //         } else {
  //           return const Splash();
  //         }
  //       // } else {
  //       //   return const Loading();
  //       // }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UiProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => FuelManager(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Findd',
        theme: ThemeData(
          primaryColor: const Color(0xFF5956E9),
          primaryColorLight: Colors.white,
          fontFamily: 'Raleway',
        ),
        initialRoute: '/',
        routes: getApplicationRoutes(),
      //  home: const HomeSplash(),
      ),
    );
  }
}
