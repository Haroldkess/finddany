import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/screens/checkoutdialogues/live_in.dart';
import 'package:shoppingyou/mobile/widgets/address_form.dart';
import 'package:shoppingyou/mobile/widgets/payment_methods.dart';
import 'package:shoppingyou/mobile/widgets/phone_form.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/database_service.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../../designParams/params.dart';
import '../../widgets/button.dart';
import '../../widgets/shiping_information.dart';

// Carrito de compras
class Checkout extends StatefulWidget {
  Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String key = '';
  @override
  void initState() {
    super.initState();
    getKey();
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
    await DatabaseService.getDeliveryPrices(context);
  }

  @override
  Widget build(BuildContext context) {
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F8),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 50 : 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
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
                              top:
                                  MediaQuery.of(context).size.width * 0.09,bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
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
                                        await Controls.shippingInfoController(
                                            context);

                                        _provider.addAdress(_provider.pref!
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
                        );
                      },
                    );
                  },
                  child: const Text('change'),
                )
              ],
            ),
            ShippingInfo(),
            Expanded(child: PaymentMethods()),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text(
                      '${currencySymbol()}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5956E9),
                      ),
                    ),
                    Text(
                      numberFormat.format(int.tryParse(
                          context.watch<UiProvider>().totalPrice.toString())),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5956E9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            LargeButton(
              text: 'Confirm and pay',
              onClick: () async {
              //  showToast("Please wait", successBlue);
                await DatabaseService.getDeliveryPrices(context);
                // ignore: use_build_context_synchronously
                if (Provider.of<UiProvider>(context, listen: false)
                    .locationType
                    .isEmpty) {
                  showToast2(context,"Kindly select delivery type", isError: true);
                } else {
                  // ignore: use_build_context_synchronously
                  liveIn(context);
                }
              },
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
