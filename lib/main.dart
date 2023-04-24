import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';
import 'package:shoppingyou/service/state/loaders.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import 'mobile/routes/routes.dart';

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
        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
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
