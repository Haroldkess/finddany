import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/main.dart';
import 'package:shoppingyou/mobile/widgets/edit_address.dart';
import 'package:shoppingyou/mobile/widgets/edit_email.dart';
import 'package:shoppingyou/mobile/widgets/edit_name.dart';
import 'package:shoppingyou/mobile/widgets/edit_phone.dart';
import 'package:shoppingyou/mobile/widgets/payment_modal.dart';
import 'package:shoppingyou/mobile/widgets/shiping_information.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/models/order_model.dart';
import 'package:shoppingyou/models/send_fuel_update.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../service/firebase_auth.dart';
import '../../service/state/fuel_manager.dart';
import 'address_form.dart';
import 'button.dart';
import 'credit_card.dart';
import 'feedback_form.dart';
import 'forget_password_email.dart';
import 'notification_view.dart';

class Modals {
  static void deleteFromCart(BuildContext cont, String id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: cont,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue.shade900.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Delete Item',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 33,
                        color: Colors.white),
                  ),
                ],
              ),
              Expanded(

                  // height: context.watch<SizeProvider>().screenHeight /  2.5,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.watch<UiProvider>().loading
                      ? const SizedBox.shrink()
                      : Button(
                          text: 'Cancel',
                          color: Colors.blue.shade900,
                          width: 150,
                          onClick: () async {
                            Navigator.pop(context);
                          },
                          height: 60,
                          fontSize: 20,
                        ),
                  context.watch<UiProvider>().loading
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          width: 10,
                        ),
                  context.watch<UiProvider>().loading
                      ? const CupertinoActivityIndicator(
                          radius: 30,
                          color: Colors.red,
                        )
                      : Button(
                          text: 'Delete',
                          color: Colors.red,
                          width: 150,
                          onClick: () async {
                            bool returned =
                                await Controls.deleteCartItem(context, id);

                            if (returned) {
                              // ignore: use_build_context_synchronously
                              await Controls.cartCollectionControl(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          },
                          height: 60,
                          fontSize: 20,
                        ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }

  static void notification(BuildContext cont) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(cont).scaffoldBackgroundColor,
      context: cont,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Image(
                    image: AssetImage('assets/images/EllipseMorado.png')),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Notifications',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 33,
                              color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                    Expanded(
                      // height: context.watch<SizeProvider>().screenHeight /  2.5,
                      child: SingleChildScrollView(
                        child: Column(
                            children: pref
                                .getStringList(notificationKey)!
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: NotificationItem(
                                        title: e,
                                        assetPath: 'assets/images/splash.png',
                                      ),
                                    ))
                                .toList()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void shipping(BuildContext cont) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(cont).scaffoldBackgroundColor,
      context: cont,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const ShippingInfo();
      },
    );
  }

  static void cards(BuildContext cont) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(cont).scaffoldBackgroundColor,
      context: cont,
      builder: (BuildContext context) {
        return const CreditCard();
      },
    );
  }

  static void editProfileInfo(BuildContext cont) async {
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(cont).scaffoldBackgroundColor,
      context: cont,
      isScrollControlled: true,
      // ignore: use_build_context_synchronously
      isDismissible:
          Provider.of<UiProvider>(cont, listen: false).loading ? false : true,
      builder: (BuildContext context) {
        return Container(
          // height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit  Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 33,
                          color: Colors.blue.shade900),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const EditName(),
                    const SizedBox(
                      height: 10,
                    ),
                    const EditEmail(),
                    const SizedBox(
                      height: 10,
                    ),
                    const EditPhone(),
                    const SizedBox(
                      height: 10,
                    ),
                    const EditAddress(),
                    const SizedBox(
                      height: 20,
                    ),
                    context.watch<UiProvider>().loading
                        ? CupertinoActivityIndicator(
                            radius: 30,
                            color: Colors.blue.shade900,
                          )
                        : Button(
                            text: 'Add',
                            width: 200,
                            height: 50,
                            onClick: () async {
                              UiProvider _provider = Provider.of<UiProvider>(
                                  context,
                                  listen: false);
                              await _provider.initializePref();
                              // ignore: use_build_context_synchronously
                              await Controls.editUserController(context);

                              _provider.addAdress(
                                  _provider.pref!.getString(addressKey)!);
                              _provider.addPhone(
                                  _provider.pref!.getString(phoneKey)!);

                              _provider.addMail(
                                  _provider.pref!.getString(emailKey)!);
                              _provider.addUserName(
                                  _provider.pref!.getString(nameKey)!);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            color: Colors.blue.shade900,
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> logOutOption(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: const Text("You will be signed out of this account?"),
              actions: <Widget>[
                Row(
                  children: [
                    TextButton(
                        child: const Text('Yes'),
                        onPressed: () async {
                          bool isLoggedOut = await AuthService.logout(context);

                          if (isLoggedOut) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()),
                                (route) => false);
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        // Do something like updating SharedPreferences or User Settings etc.
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }

  static void processOrder(
      BuildContext cont, List<AdminOrderModel> adminDeals, String id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: cont,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue.shade900.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Process Order',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 33,
                        color: Colors.white),
                  ),
                ],
              ),
              Expanded(

                  // height: context.watch<SizeProvider>().screenHeight /  2.5,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.watch<UiProvider>().loading
                      ? const SizedBox.shrink()
                      : Button(
                          text: 'Cancel',
                          color: Colors.red.shade900,
                          width: Responsive.isMobile(context) ||
                                  Responsive.isMobileLarge(context)
                              ? 100
                              : 200,
                          onClick: () async {
                            Navigator.pop(context);
                          },
                          height: 60,
                          fontSize: 20,
                        ),
                  context.watch<UiProvider>().loading
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          width: 10,
                        ),
                  context.watch<UiProvider>().loading
                      ? const CupertinoActivityIndicator(
                          radius: 30,
                          color: Colors.blue,
                        )
                      : Button(
                          text: 'Process',
                          color: Colors.blue.shade900,
                          width: Responsive.isMobile(context) ||
                                  Responsive.isMobileLarge(context)
                              ? 120
                              : 200,
                          onClick: () async {
                            bool returned = await Controls.process(
                                context, adminDeals, id, true);

                            if (returned) {
                              {
                                Navigator.pop(cont);
                              }
                            }
                          },
                          height: 60,
                          fontSize: 20,
                        ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }

  static void adminShopInfo(BuildContext cont, AdminOrderModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(cont).scaffoldBackgroundColor,
      context: cont,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Image(
                    image: AssetImage('assets/images/EllipseMorado.png')),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Seller Info',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 33,
                              color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                    Expanded(
                      // height: context.watch<SizeProvider>().screenHeight /  2.5,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          NotificationItem(
                            title:
                                "Shop name is ${model.shopName}, with shop contact : ${model.shopPhoneNumber}",
                            assetPath: 'assets/images/splash.png',
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void enableModal(BuildContext cont, String id, bool value) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: cont,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue.shade900.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value ? 'Stop orders' : 'Start orders',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 33,
                        color: Colors.white),
                  ),
                ],
              ),
              Expanded(

                  // height: context.watch<SizeProvider>().screenHeight /  2.5,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.watch<UiProvider>().loading
                      ? const SizedBox.shrink()
                      : Button(
                          text: 'Cancel',
                          color: Colors.red.shade900,
                          width: 200,
                          onClick: () async {
                            Navigator.pop(context);
                          },
                          height: 60,
                          fontSize: 20,
                        ),
                  context.watch<UiProvider>().loading
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          width: 10,
                        ),
                  context.watch<UiProvider>().loading
                      ? const CupertinoActivityIndicator(
                          radius: 30,
                          color: Colors.blue,
                        )
                      : Button(
                          text: 'yes',
                          color: Colors.blue.shade900,
                          width: 200,
                          onClick: () async {
                            bool returned =
                                await Controls.enable(context, id, value);

                            if (returned) {
                              // ignore: use_build_context_synchronously
                              //    await Controls.cartCollectionControl(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          },
                          height: 60,
                          fontSize: 20,
                        ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }

  static void forgetPasswordModal(
      BuildContext cont, TextEditingController controller) async {
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(cont).scaffoldBackgroundColor,
      context: cont,
      isScrollControlled: true,
      // ignore: use_build_context_synchronously
      isDismissible:
          Provider.of<UiProvider>(cont, listen: false).loading ? false : true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please input your email',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.blue.shade900),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ForgetPasswordEmail(
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    context.watch<UiProvider>().loading
                        ? CupertinoActivityIndicator(
                            radius: 30,
                            color: Colors.blue.shade900,
                          )
                        : Button(
                            text: 'Continue',
                            width: 200,
                            height: 50,
                            onClick: () async {
                              UiProvider _provider = Provider.of<UiProvider>(
                                  context,
                                  listen: false);
                              _provider.load(true);

                              bool awaitTask =
                                  await AuthService.runForgetPassword(
                                      controller.text);
                              _provider.load(false);

                              if (awaitTask) {
                                _provider.load(false);

                                showToast2(context,
                                    'Reset password link has been sent to ${controller.text}');
                              } else {
                                _provider.load(false);

                                showToast2(context, 'Reset password failed',
                                    isError: true);
                              }
                              _provider.load(false);
                              Navigator.pop(context);
                            },
                            color: Colors.blue.shade900,
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> sendFeedBack(
      BuildContext context, TextEditingController controller) async {
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                FeedBackForm(
                  controller: controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                context.watch<UiProvider>().loading
                    ? CupertinoActivityIndicator(
                        radius: 30,
                        color: Colors.blue.shade900,
                      )
                    : Button(
                        text: 'Send',
                        width: 200,
                        height: 50,
                        onClick: () async {
                          // ignore: use_build_context_synchronously
                          await Controls.sendFeedBackController(
                              context, controller.text);

                          Navigator.pop(context);
                        },
                        color: Colors.blue.shade900,
                      ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> adjustFuelMeter(
      BuildContext context,
      TextEditingController price,
      TextEditingController fare,
      TextEditingController litres,
      TextEditingController max,
      TextEditingController min) async {
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                FeedBackForm(
                    controller: price,
                    name: "Price",
                    type: TextInputType.number),
                const SizedBox(
                  height: 10,
                ),
                FeedBackForm(
                    controller: litres,
                    name: "Litres",
                    type: TextInputType.number),
                const SizedBox(
                  height: 10,
                ),
                FeedBackForm(
                    controller: max,
                    name: "Max-Litres",
                    type: TextInputType.number),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                FeedBackForm(
                    controller: min,
                    name: "Min-Litres",
                    type: TextInputType.number),
                const SizedBox(
                  height: 10,
                ),
                FeedBackForm(
                    controller: fare, name: "Fare", type: TextInputType.number),
                const SizedBox(
                  height: 10,
                ),
                context.watch<UiProvider>().loading
                    ? CupertinoActivityIndicator(
                        radius: 30,
                        color: Colors.blue.shade900,
                      )
                    : Button(
                        text: 'Send',
                        width: 200,
                        height: 50,
                        onClick: () async {
                          FuelManager fuel =
                              Provider.of<FuelManager>(context, listen: false);
                          FuelUpdate fuelData = FuelUpdate(
                              fare: fare.text.isNotEmpty
                                  ? int.tryParse(fare.text)
                                  : fuel.fare,
                              litres: litres.text.isNotEmpty
                                  ? int.tryParse(litres.text)
                                  : fuel.availableLitres,
                              maxLitres: max.text.isNotEmpty
                                  ? int.tryParse(max.text)
                                  : fuel.maxLitres,
                              minLitres: min.text.isNotEmpty
                                  ? int.tryParse(min.text)
                                  : fuel.minLitres,
                              price: price.text.isNotEmpty
                                  ? int.tryParse(price.text)
                                  : fuel.sellingPrice.toInt());

                          // ignore: use_build_context_synchronously
                          await Controls.updateFuelController(
                              context, fuelData);

                          Navigator.pop(context);
                        },
                        color: Colors.blue.shade900,
                      ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
