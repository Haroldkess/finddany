import 'dart:io';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/fuel/fuelcontrol/fuel_control.dart';
import 'package:shoppingyou/mobile/fuel/fuelmodals/fuel_param.dart';
import 'package:shoppingyou/mobile/fuel/fuelmodals/live_question.dart';
import 'package:shoppingyou/mobile/widgets/edit_address.dart';
import 'package:shoppingyou/mobile/widgets/edit_delivery.dart';
import 'package:shoppingyou/mobile/widgets/edit_phone.dart';
import 'package:shoppingyou/mobile/widgets/payment_methods.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service/constant.dart';
import '../../../service/controller.dart';
import '../../../service/state/ui_manager.dart';
import '../../screens/purchase_screens/cart.dart';
import '../../widgets/address_form.dart';
import '../../widgets/button.dart';
import '../../widgets/phone_form.dart';
import '../../widgets/shiping_information.dart';
import '../../widgets/toast.dart';

class FuelModal {
  static Future<void> fuelModal(
    BuildContext context,
    TextEditingController controller,
  ) async {
    FuelManager _provider = Provider.of<FuelManager>(context, listen: false);
    UiProvider _Uiprovider = Provider.of<UiProvider>(context, listen: false);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
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
                  height: 15,
                ),
                const FuelAlertError(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Shipping information?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
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
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.09,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  left: 15,
                                  right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const EditPhone(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const EditAddress(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  EditDeliveryAddress(),
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
                                            await _Uiprovider.initializePref();
                                            // ignore: use_build_context_synchronously
                                            await Controls
                                                .shippingInfoController(
                                                    context);

                                            _Uiprovider.addAdress(_Uiprovider
                                                .pref!
                                                .getString(addressKey)!);
                                            _Uiprovider.addUserCordinates(
                                                _Uiprovider.pref!
                                                    .getString(cordinatesKey)!);
                                            _Uiprovider.addPhone(_Uiprovider
                                                .pref!
                                                .getString(phoneKey)!);
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          },
                                          color: Colors.blue.shade900,
                                        ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('change'),
                    )
                  ],
                ),
                ShippingInfo(),
                const SizedBox(
                  height: 10,
                ),
                const FuelParam(),
                const SizedBox(
                  height: 10,
                ),
                FuelExtra(controller: controller),
                const SizedBox(
                  height: 10,
                ),
                FuelLiveIn(),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    const Text(
                      'You can also buy from us',
                      style: TextStyle(
                          //color: Colors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () async {
                        const String googleMapsUrl =
                            "https://www.google.com/maps/search/?api=1&query=37.7749,-122.4194";
                        const String appleMapsUrl =
                            "https://maps.apple.com/?q=37.7749,-122.4194";

                        if (await canLaunch(googleMapsUrl)) {
                          await launch(googleMapsUrl);
                        } else if (await canLaunch(appleMapsUrl)) {
                          await launch(appleMapsUrl);
                        } else {
                          throw 'Could not launch URL';
                        }
                      },
                      child: Text(
                        ' Here',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                //   PaymentMethods(),
                const SizedBox(
                  height: 10,
                ),
                const FuelAlertError2(),
                const SizedBox(
                  height: 30,
                ),
                context.watch<FuelManager>().loadStatus
                    ? CupertinoActivityIndicator(
                        radius: 15,
                        color: Colors.blue.shade900,
                      )
                    : Button(
                        text: 'Proceed',
                        width: 200,
                        height: 50,
                        onClick: () async {
                          if (_Uiprovider.name == 'null' ||
                              _Uiprovider.phoneNumber == 'null' ||
                              _Uiprovider.address == 'null') {
                            showToast2(
                                context, 'Please add a valid shipping info',
                                isError: true);
                            return;
                          }

                          if (_Uiprovider.cordinates == 'null' ||
                              _Uiprovider.cordinates.isEmpty) {
                            showToast2(
                                context, 'Please add a valid Exact location',
                                isError: true);
                            return;
                          }
                          if (_provider.selectedLires < 1) {
                            showToast2(context, "Liters cannot be less than 1",
                                isError: true);
                            return;
                          }
                          if (_provider.liveIn.isEmpty) {
                            showToast2(context, "Please complete form",
                                isError: true);
                            return;
                          }
                          if (_provider.selectedLires >=
                              _provider.availableLitres) {
                            showToast2(context,
                                "You cannot Buy more than our available Litres",
                                isError: true);
                            return;
                          }
                          if (_provider.liveIn == "No") {
                            showToast2(context,
                                "Sorry this feature is not available in your region",
                                isError: true);
                            return;
                          } else {
                            if (kIsWeb) {
                              await FuelControl.makePayment(
                                context,
                                controller.text,
                              );
                            } else {
                              await FuelControl.makePaymentMobile(
                                  context, controller.text);
                            }
                          }
                          // ignore: use_build_context_synchronously
                          // await Controls.sendFeedBackController(
                          //     context, controller.text);

                          //Navigator.pop(context);
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
