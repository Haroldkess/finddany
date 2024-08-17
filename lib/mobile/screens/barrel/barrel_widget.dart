import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/mobile/screens/barrel/barrel_controller/barrels_controller.dart';
import 'package:shoppingyou/mobile/screens/barrel/my_barrel/my_barrel_screen.dart';
import 'package:shoppingyou/mobile/screens/purchase_screens/cart.dart';
import 'package:shoppingyou/mobile/widgets/pop_up.dart';
import 'package:shoppingyou/mobile/widgets/text.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/firebase_calls.dart';

class BarrelWidgets {
  static void buyBarrelSheet(context) {
    BarrelController.instance.getBarrel();
    Get.bottomSheet(
      SizedBox(
          width: Get.width,
          child: GetBuilder(
              init: BarrelController(),
              builder: (barrel) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const AppText(
                        text: "Own your barrel",
                        size: 18,
                        color: Colors.black,
                        weight: FontWeight.w800,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text:
                                      "Liters: ${barrel.barrel.value.litre ?? ""}",
                                  size: 14,
                                  color: Colors.black,
                                  weight: FontWeight.w600,
                                ),
                                AppText(
                                  text: barrel.barrel.value.price == null
                                      ? ""
                                      : "Price: ${currencySymbol()}${barrel.barrel.value.price!.isNegative ? "" : numberFormat.format(barrel.barrel.value.price)}",
                                  size: 14,
                                  color: Colors.black,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeInUpBig(
                              duration: const Duration(seconds: 1),
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.asset(
                                  'assets/images/barrel.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const FuelAlertError2(
                              alert:
                                  "Start your oil business now and scale as you desire!",
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            barrel.loadPay.value
                                ? Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.blue[900]),
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff5956E9),
                                        fixedSize: const Size(314.0, 60.0),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 22),
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                    child: const Text(
                                      "Own barrel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      bool value = await Controls.checkEnable(
                                          context, 'oneGod1997');

                                      await BarrelController.instance
                                          .getBarrel(referesh: true);

                                      DocumentSnapshot? documentSnapshot =
                                          await firestore
                                              .collection("my_barrels")
                                              .doc(pref.getString(userIdKey))
                                              .get();
                                      if (documentSnapshot.exists) {
                                        if (value == false) {
                                          // ignore: use_build_context_synchronously
                                          AppSnackBar.snackBar(
                                              message:
                                                  'We are closed kindly come back tomorrow',
                                              head: "Closed",
                                              isError: true);
                                          return;
                                        }

                                        if (Timestamp.now().toDate().compareTo(
                                                barrel.myBarrel.value
                                                    .finalExpiration!
                                                    .toDate()) >=
                                            0) {
                                          if (value == false) {
                                            // ignore: use_build_context_synchronously
                                            AppSnackBar.snackBar(
                                                message:
                                                    'We are closed kindly come back tomorrow',
                                                head: "Closed",
                                                isError: true);
                                            return;
                                          }
                                          barrel.changeType("buy");

                                          if (barrel.barrel.value.id != null) {
                                            if (barrel.barrel.value.stock! <
                                                1) {
                                              AppSnackBar.snackBar(
                                                  message:
                                                      "No barrels available at the time",
                                                  head: "Unavailable",
                                                  isError: true);
                                              return;
                                            }
                                            if (kIsWeb) {
                                              await barrel.makePayment(context,
                                                  barrel.barrel.value.price!);
                                            } else {
                                              await barrel.makePaymentMobile(
                                                  context,
                                                  barrel.barrel.value.price!);
                                            }
                                          } else {
                                            AppSnackBar.snackBar(
                                                message:
                                                    "Can't get barrel ata the time.",
                                                head: "Unavailable",
                                                isError: true);
                                            return;
                                          }
                                        } else {
                                          if (barrel.myBarrel.value.expires!
                                                  .toDate()
                                                  .compareTo(barrel
                                                      .myBarrel.value.expires!
                                                      .toDate()
                                                      .add(const Duration(
                                                          days: 3))) >=
                                              0) {
                                            barrel.changeType("repair");
                                            if (barrel.barrel.value.id !=
                                                null) {
                                              if (barrel.barrel.value.stock! <
                                                  1) {
                                                AppSnackBar.snackBar(
                                                    message:
                                                        "No barrels available at the time",
                                                    head: "Unavailable",
                                                    isError: true);
                                                return;
                                              }
                                              if (kIsWeb) {
                                                await barrel.makePayment(
                                                    context,
                                                    barrel.barrel.value.price!);
                                              } else {
                                                await barrel.makePaymentMobile(
                                                    context,
                                                    barrel.barrel.value.price!);
                                              }
                                            }
                                          } else {
                                            barrel.changeType("repair");
                                            if (barrel.barrel.value.id !=
                                                null) {
                                              if (barrel.barrel.value.stock! <
                                                  1) {
                                                AppSnackBar.snackBar(
                                                    message:
                                                        "No barrels available at the time",
                                                    head: "Unavailable",
                                                    isError: true);
                                                return;
                                              }
                                              if (kIsWeb) {
                                                await barrel.makePayment(
                                                    context,
                                                    barrel
                                                        .barrel.value.repair!);
                                              } else {
                                                await barrel.makePaymentMobile(
                                                    context,
                                                    barrel
                                                        .barrel.value.repair!);
                                              }
                                            }
                                          }
                                        }
                                      } else {
                                        if (value == false) {
                                          // ignore: use_build_context_synchronously
                                          AppSnackBar.snackBar(
                                              message:
                                                  'We are closed kindly come back tomorrow',
                                              head: "Closed",
                                              isError: true);
                                          return;
                                        }
                                        barrel.changeType("buy");

                                        if (barrel.barrel.value.id != null) {
                                          if (barrel.barrel.value.stock! < 1) {
                                            AppSnackBar.snackBar(
                                                message:
                                                    "No barrels available at the time",
                                                head: "Unavailable",
                                                isError: true);
                                            return;
                                          }
                                          if (kIsWeb) {
                                            await barrel.makePayment(context,
                                                barrel.barrel.value.price!);
                                          } else {
                                            await barrel.makePaymentMobile(
                                                context,
                                                barrel.barrel.value.price!);
                                          }
                                        }
                                      }
                                      // ignore: use_build_context_synchronously
                                    },
                                  ),
                          ]).paddingAll(10),
                    ],
                  ),
                );
              })),
      elevation: 30,
      ignoreSafeArea: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      enableDrag: true,
      isScrollControlled: false,
    );
  }

  static void seeBarrelSheet() {
    BarrelController.instance.getMyBarrel();

    Get.bottomSheet(
      Scaffold(
        body: BarrelScreen(),
      ),
      elevation: 30,
      ignoreSafeArea: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}
