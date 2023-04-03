import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/screens/profile_screen/profile.dart';
import 'package:shoppingyou/mobile/screens/purchase_screens/cart.dart';
import 'package:shoppingyou/mobile/screens/home/searchscreen.dart';
import 'package:shoppingyou/models/user_model.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/database_service.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import '../other_screens/no_history.dart';
import 'iniciopage.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  String? userName = '';
  @override
  void initState() {
    super.initState();
    // Controls.getHomeProduct(context);
    // Controls.getHomeProduct(context);
    // Controls.getQuickPicksProduct(context);
    // Controls.getSliderProduct(context);
    // Controls.getPopularProduct(context);
    // Controls.getJustForYouProduct(context);
    // Controls.getCategory(context);
    // Controls.cartCollectionControl(context);

    // saveInfo(context);
  }

  Future<void> saveInfo(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserModel user = await DatabaseService.getUserWithId();

    await pref.setStringList(notificationKey, ['Welcome to shop you']);

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
    print('done getting some user info');
  }

  int _currentIndex = 0;

  final List _children =  const [
    InicioPage(),
    InicioPage(),
    InicioPage(),
    InicioPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(89, 86, 233, 1),
        iconSize: 30,
        elevation: 0.9,
        backgroundColor: const Color(0xfff2f2f2),
        items:  [
      const    BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Color(0xff200E32)),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Color(0xff5956E9),
              )),
      const    BottomNavigationBarItem(
              icon: Icon(Icons.pedal_bike_outlined, color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: 'Deals',
              activeIcon: Icon(
                Icons.favorite,
                color: Color(0xff5956E9),
              )),
     const     BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: 'Profile',
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff5956E9),
              )),
          BottomNavigationBarItem(
            
              icon:
                  Icon(Icons.shopping_cart_outlined, color: context.watch<UiProvider>().cartList.isNotEmpty ? Colors.red : Color(0xff200E32)),
              backgroundColor: const Color(0xff5956E9),
              label: 'Cart ${context.watch<UiProvider>().cartList.length.toString()}',
              activeIcon:  Icon(
                Icons.shopping_cart,
                color: context.watch<UiProvider>().cartList.isNotEmpty ? Colors.red :  Color(0xff5956E9),
              )),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    Widget page = Home();
    switch (index) {
      case 1:
        page = DoneDeals();
        break;
      case 2:
        page = Profile();
        break;
      case 3:
        page = Cart();
        break;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
    // setState(() {
    //   _currentIndex = index;
    //   print(index);
    // });
  }
}
