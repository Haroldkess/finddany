import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/admin/dashboard.dart';
import 'package:shoppingyou/mobile/screens/addProduct.dart';
import 'package:shoppingyou/mobile/screens/no_history.dart';
import 'package:shoppingyou/mobile/screens/profile.dart';
import 'package:shoppingyou/models/ui_model.dart';

import '../screens/checkout.dart';
import '../screens/fuel_history.dart';
import '../screens/homeSplash.dart';
import '../screens/homescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/no_favorites.dart';
import '../screens/searchscreen.dart';
import '../screens/signUp.dart';
import '../screens/splashscreen.dart';
import '../widgets/drawer.dart';
import '../widgets/loading_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeSplash(),
    'homeScreen': (BuildContext context) => AppDrawer(child: Home()),
    'splash': (BuildContext contex) => Splash(),
    'auth': (BuildContext contex) => Login(),
    'favorites': (BuildContext contex) => NoFavorites(),
    'checkout': (BuildContext contex) => Checkout(),
    'busqueda': (BuildContext contex) => SearchScreen(),
    'signUp': (BuildContext context) => SignUp(),
    'post_product': (BuildContext context) => AddProduct(),
    'deals': (BuildContext context) => DoneDeals(),
    'profile': (BuildContext context) => Profile(),
    'Admin': (BuildContext context) => DashBoard(),
    'Fuel': (BuildContext context) => FuelHistory(),
  };
}
