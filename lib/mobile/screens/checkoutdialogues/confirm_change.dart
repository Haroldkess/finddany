import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/payment_modal.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';

import '../../../service/constant.dart';
import '../../../service/controller.dart';
import '../../../service/state/ui_manager.dart';
import '../../widgets/address_form.dart';
import '../../widgets/button.dart';
import '../../widgets/phone_form.dart';
import '../../widgets/shiping_information.dart';

Future<void> confirmLocation(BuildContext context) async {
  UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
  return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const Text(
                    "Are these your correct Informations?",
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Shipping information',
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
                        Navigator.pop(context);
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
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.09),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const ShippingAddress(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const ShippingPhone(),
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
                                              await _provider.initializePref();
                                              // ignore: use_build_context_synchronously
                                              await Controls
                                                  .shippingInfoController(
                                                      context);

                                              _provider.addAdress(_provider
                                                  .pref!
                                                  .getString(addressKey)!);
                                              _provider.addPhone(_provider.pref!
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
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('yes', style: TextStyle(color: Colors.blue[900]),),
                    onPressed: () async {
                      late int _price;
                      UiProvider shipPrice =
                          Provider.of<UiProvider>(context, listen: false);
                      if (shipPrice.locationType == "Home") {
                        _price = shipPrice.deliveryPrices.first;
                      } else {
                        _price =  shipPrice.deliveryPrices.last;
                      }
                      if (_provider.name == 'null' ||
                          _provider.phoneNumber == 'null' ||
                          _provider.address == 'null') {
                        showToast2(context,'Please add a valid shipping info', isError: true);
                        return;
                      }
                      showModalBottomSheet<void>(
                        context: context,
                        isDismissible: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return PaymentModal(
                            addedPrice: _price,
                          );
                        },
                      );
                    },
                  ),
                  TextButton(
                    child: Text('No', style: TextStyle(color: Colors.red[900]),),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
      });
}
