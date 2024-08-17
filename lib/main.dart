import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/firebase_options.dart';
import 'package:shoppingyou/mobile/screens/barrel/barrel_controller/barrels_controller.dart';
import 'package:shoppingyou/service/fcm_n.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';
import 'package:shoppingyou/service/state/loaders.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import 'mobile/routes/routes.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

//import 'package:fast_cached_network_image/fast_cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await NotificationController.requestPermission();
  }
  Get.put(BarrelController());
//  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

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
      child: kIsWeb
          ? GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Quickliy',
              theme: ThemeData(
                primaryColor: const Color(0xFF5956E9),
                primaryColorLight: Colors.white,
                //  fontFamily: 'Raleway',
              ),
              initialRoute: '/',
              routes: getApplicationRoutes(),
              //  home: const HomeSplash(),
            )
          : OverlaySupport(
              toastTheme: ToastThemeData(alignment: Alignment.center),
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Quickliy',
                theme: ThemeData(
                  primaryColor: const Color(0xFF5956E9),
                  primaryColorLight: Colors.white,
                  // fontFamily: 'Raleway',
                ),
                initialRoute: '/',
                routes: getApplicationRoutes(),
                //  home: const HomeSplash(),
              )),
    );
  }
}
