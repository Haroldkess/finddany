import 'dart:developer';

import 'package:animate_do/animate_do.dart';
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
import '../../../service/controller.dart';
import '../other_screens/no_history.dart';
import 'iniciopage.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  String? userName = '';
  bool? showMesssage = true;
  @override
  void initState() {
    super.initState();
    showMessage();
  }

  showMessage() async {
    await Future.delayed(Duration(seconds: 5)).whenComplete(() {
      setState(() {
        showMesssage = false;
      });
    });
  }

  String? url;
  _launchInWebViewOrVC(String urlLink) async {
    url = urlLink;

    if (await canLaunch(url!)) {
      await launch(
        url!,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
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

  final List _children = const [
    InicioPage(),
    InicioPage(),
    InicioPage(),
    InicioPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: [
          _children[_currentIndex],
          showMesssage!
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: FadeInUp(
                    animate: true,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(1000, 300),
                            bottomRight: Radius.elliptical(1000, 300),
                          ),
                        ),
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Chat with us here !",
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Icon(Icons.arrow_downward_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(89, 86, 233, 1),
        iconSize: 30,
        elevation: 0.9,
        backgroundColor: const Color(0xfff2f2f2),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Color(0xff200E32)),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Color(0xff5956E9),
              )),
          const BottomNavigationBarItem(
              icon: Icon(Icons.pedal_bike_outlined, color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: 'Deals',
              activeIcon: Icon(
                Icons.favorite,
                color: Color(0xff5956E9),
              )),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: 'Profile',
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff5956E9),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined,
                  color: context.watch<UiProvider>().cartList.isNotEmpty
                      ? Colors.red
                      : Color(0xff200E32)),
              backgroundColor: const Color(0xff5956E9),
              label:
                  'Cart ${context.watch<UiProvider>().cartList.length.toString()}',
              activeIcon: Icon(
                Icons.shopping_cart,
                color: context.watch<UiProvider>().cartList.isNotEmpty
                    ? Colors.red
                    : Color(0xff5956E9),
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        isExtended: true,
        onPressed: () async {
          await Utility.launchInWebViewOrVC(Uri.parse(
              "https://wa.me/+2348070578450/?text=Hello there. i want to make some enquiry from FinddAny"));
        },
        child: Image.asset(
          'assets/images/su3.png',
          height: 50,
          width: 50,
          fit: BoxFit.contain,
          //color: Colors.white,
        ),
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
