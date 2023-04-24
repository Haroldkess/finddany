import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/fuel/fuel_card.dart';

import 'package:shoppingyou/mobile/screens/home/searchscreen.dart';
import 'package:shoppingyou/mobile/widgets/animated_header.dart';
import 'package:shoppingyou/mobile/widgets/banner.dart';
import 'package:shoppingyou/mobile/widgets/category_chips.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/mobile/widgets/tabbarmenu.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/database_service.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../../models/user_model.dart';
import '../../../service/state/fuel_manager.dart';
import '../../fuel/fuelcontrol/fuel_control.dart';
import '../../fuel/fuelmodals/fuel_modal.dart';
import '../../widgets/drawer.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/toast.dart';
import '../../widgets/vendor_info.dart';

class InicioPage extends StatefulWidget {
  final String? name;
  const InicioPage({Key? key, this.name}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  TextEditingController controller = TextEditingController();
  String key = '';
  @override
  void initState() {
    super.initState();
    // getKey();
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

    await PaystackClient.initialize(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.1,
        title: Semantics(
          label: appName,
          child: Text(
            appName,
            style: const TextStyle(
                fontFamily: 'Raleway',
                color: Color(0xff5956E9),
                fontSize: 25.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              AppDrawer.of(context)?.toggle();
            },
            icon:
                const Icon(Icons.segment, color: Color(0xff5956E9), size: 30)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Color(0xff5956E9),
              )),
          Responsive(
            mobile: const SizedBox.shrink(),
            desktop: IconButton(
                onPressed: () async {
                  await _submit(context);
                },
                icon: const Icon(
                  FontAwesomeIcons.gasPump,
                  size: 17,
                  color: Color(0xff5956E9),
                )),
            tablet: IconButton(
                onPressed: () async {
                  await _submit(context);
                },
                icon: const Icon(
                  FontAwesomeIcons.gasPump,
                  size: 17,
                  color: Color(0xff5956E9),
                )),
            mobileLarge: const SizedBox.shrink(),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Modals.notification(context);
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Color.fromRGBO(89, 86, 233, 1),
                  )),
              const Positioned(
                right: 2.0,
                top: 5.0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Stack(
        //    alignment: Alignment.centerRight,
        children: [
          Container(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height * 7,
                    child: SingleChildScrollView(
                      child: context.watch<UiProvider>().prod.isNotEmpty
                          ? Column(
                              children: const [
                                Responsive(
                                  mobile: FuelCard(),
                                  desktop: AnimatedLargeHeader(),
                                  tablet: AnimatedLargeHeader(),
                                  mobileLarge: FuelCard(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //  Responsive.isMobile(context) ?   BannerSlider() : SizedBox.shrink(),

                                Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: CategoryChips(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: SelectionScreen(),
                                ),
                              ],
                            )
                          : EmptyState(
                              path: 'assets/images/no_connection.png',
                              title: 'No Connection',
                              description:
                                  'Hit the blue button down below to Reload',
                              textButton: 'Retry',
                              onClick: () async {
                                Provider.of<UiProvider>(context, listen: false)
                                    .load(true);
                                try {
                                  callApis(context).whenComplete(() {
                                    Provider.of<UiProvider>(context,
                                            listen: false)
                                        .load(false);
                                  }).catchError((e) {
                                    Provider.of<UiProvider>(context,
                                            listen: false)
                                        .load(false);
                                  });
                                } catch (e) {
                                  Provider.of<UiProvider>(context,
                                          listen: false)
                                      .load(false);
                                }
                                Provider.of<UiProvider>(context, listen: false)
                                    .load(false);
                                //Navigator.pop(context);
                              },
                            ),
                    ),
                  ))),
          // context.watch<UiProvider>().hasShop
          //     ? const SizedBox.shrink()
          //     : Positioned(
          //       top: MediaQuery.of(context).size.height / 2,
          //       right: 0.1, child: HowToBeAVendor())
        ],
      ),
    );
  }

  _submit(BuildContext context) async {
    await getKey();
    bool value =
        // ignore: use_build_context_synchronously
        await Controls.checkEnable(context, 'oneGod1997');
    // ignore: use_build_context_synchronously
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
      // ignore: use_build_context_synchronously
      if (Provider.of<FuelManager>(context, listen: false).availableLitres <
          5) {
        showToast2(context, "We are Low on fuel kindly check in Next time",
            isError: true);
        return;
        // ignore: use_build_context_synchronously
      } else {
        // ignore: use_build_context_synchronously
        FuelModal.fuelModal(context, controller);
      }
    } else {
      showToast2(context, "Can't get fuel meters at the moment..",
          isError: true);
      return;
    }
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
    await Provider.of<UiProvider>(context, listen: false)
        .addHasShop(pref.getBool(hasShopKey)!);
    await Provider.of<UiProvider>(context, listen: false)
        .addMail(pref.getString(emailKey)!);

    await Provider.of<UiProvider>(context, listen: false)
        .addDp(pref.getString(dpKey)!);
    print('done getting some user info');
  }
}
