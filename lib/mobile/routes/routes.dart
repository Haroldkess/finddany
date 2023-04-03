import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/admin/dashboard.dart';
import 'package:shoppingyou/mobile/screens/addProduct.dart';
import 'package:shoppingyou/mobile/screens/profile_screen/profile.dart';
import '../screens/auth_screens/loginscreen.dart';
import '../screens/auth_screens/signUp.dart';

import '../screens/home/homeSplash.dart';
import '../screens/home/homescreen.dart';
import '../screens/other_screens/fuel_history.dart';
import '../screens/other_screens/no_favorites.dart';
import '../screens/other_screens/no_history.dart';
import '../screens/purchase_screens/checkout.dart';
import '../screens/home/searchscreen.dart';
import '../screens/splashscreen.dart';
import '../widgets/drawer.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const HomeSplash(),
    'homeScreen': (BuildContext context) => AppDrawer(child: Home()),
    'splash': (BuildContext contex) => const Splash(),
    'auth': (BuildContext contex) =>const Login(),
    'favorites': (BuildContext contex) =>const  NoFavorites(),
    'checkout': (BuildContext contex) =>  Checkout(),
    'busqueda': (BuildContext contex) => const SearchScreen(),
    'signUp': (BuildContext context) =>  const SignUp(),
    'post_product': (BuildContext context) => const AddProduct(),
    'deals': (BuildContext context) => const DoneDeals(),
    'profile': (BuildContext context) => const Profile(),
    'Admin': (BuildContext context) => const DashBoard(),
    'Fuel': (BuildContext context) => const FuelHistory(),
  };
}
