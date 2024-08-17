// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/fuel/fuel_card.dart';
import 'package:shoppingyou/mobile/screens/other_screens/banner.dart';
import 'package:shoppingyou/mobile/screens/other_screens/fuel_transaction.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/database_service.dart';
import 'package:shoppingyou/service/operations.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../../models/user_model.dart';
import '../../../service/state/fuel_manager.dart';
import '../../fuel/fuelcontrol/fuel_control.dart';
import '../../widgets/drawer.dart';
import '../../widgets/toast.dart';

class InicioPage extends StatefulWidget {
  final String? name;
  const InicioPage({Key? key, this.name}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  // final updateHelper = UpdateHelper.instance;
  TextEditingController controller = TextEditingController();
  String key = '';
  @override
  void initState() {
    super.initState();

    // getKey();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFuelCart(context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      callApis(context);
    });
    // getKey();
  }

  Future getFuelCart(BuildContext context) async {
    if (Provider.of<UiProvider>(context, listen: false).fuelOrders.isNotEmpty) {
      return;
    }
    await Controls.fuelHistoryController(context);
  }

  Future<void> getKey() async {
    await FirebaseFirestore.instance
        .collection("controls")
        .doc('oneGod1997')
        .get()
        .then((value) {
      String _key = value.data()!["key"];
      setState(() {
        key = _key;
      });
    });

    //  await PaystackClient.initialize(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi ${context.watch<UiProvider>().name}",
              style: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Color.fromARGB(255, 155, 148, 148),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text(
                "i'm here to make things easy for you",
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              AppDrawer.of(context)?.toggle();
            },
            icon:
                const Icon(Icons.segment, color: Color(0xff5956E9), size: 30)),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'profile');
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: context.watch<UiProvider>().imageUrl.isEmpty
                          ? const AssetImage('assets/images/avatar.png')
                              as ImageProvider
                          : CachedNetworkImageProvider(
                              context.watch<UiProvider>().imageUrl))),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Stack(
        //    alignment: Alignment.centerRight,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 7,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    // Responsive(
                    //   mobile: FuelCard(),
                    //   desktop: AnimatedLargeHeader(),
                    //   tablet: AnimatedLargeHeader(),
                    //   mobileLarge: FuelCard(),
                    // ),
                    FuelCard(
                      pub: key,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    BannerHold(),

                    const SizedBox(
                      height: 20,
                    ),
                    const FuelTransaction()
                  ],
                )),
              )),
        ],
      ),
    );
  }

  _submit(BuildContext context) async {
    await getKey();
    bool value = await Controls.checkEnable(context, 'oneGod1997');

    bool gotten = await FuelControl.getFuelValues(context);

    if (value == false) {
      showToast2(context, 'We are closed kindly come back tomorrow',
          isError: true);
      return;
    }

    if (gotten) {
      showToast2(
        context,
        "Fuel meters gotten successfully",
      );

      if (Provider.of<FuelManager>(context, listen: false).availableLitres <
          5) {
        showToast2(context, "We are Low on fuel kindly check in Next time",
            isError: true);
        return;
      } else {
        // FuelModal.fuelModal(context, controller);
      }
    } else {
      showToast2(context, "Can't get fuel meters at the moment..",
          isError: true);
      return;
    }
  }

  Future<void> callApis(context) async {
    await Controls.getHomeProduct(context, false);
    //  await Controls.getQuickPicksProduct(context);
    //  await Controls.getSliderProduct(context);
    //  await Controls.getPopularProduct(context);
    //  await Controls.getJustForYouProduct(context);
    //  await Controls.getCategory(context);

    await saveInfo(context);
    //await Future.delayed(const Duration(seconds: 3));
    //  Navigator.pushReplacementNamed(context, 'home');
  }

  Future<void> saveInfo(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserModel user = await DatabaseService.getUserWithId();

    await pref.setStringList(notificationKey, ['Welcome to shop you']);

    await pref.setString(userIdKey, user.id!);
    await pref.setString(nameKey, user.name!);

    await pref.setString(emailKey, user.email!);
    if (user.userLocation != null) {
      if (user.userLocation!.isNotEmpty) {
        if (user.userLocation!.contains("|||")) {
          String value = user.userLocation!.split("|||").last;
          // Operations.debug(value);

          //  Operations.debug(user.userLocation!.split("|||").first);
          await pref.setString(cordinatesKey, value.isEmpty ? "null" : value);
          await Provider.of<UiProvider>(context, listen: false)
              .addUserCordinates(pref.getString(cordinatesKey)!);
        }
      }
    }

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
    Operations.debug('done getting some user info');
  }
}
