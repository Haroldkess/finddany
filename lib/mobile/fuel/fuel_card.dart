import 'dart:developer';
import 'package:flutter/foundation.dart';
// import 'package:vibration/vibration.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
// import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/fuel/fuelcontrol/fuel_control.dart';
import 'package:shoppingyou/mobile/fuel/fuelmodals/fuel_modal.dart';
import 'package:shoppingyou/mobile/widgets/button.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';

import '../../service/controller.dart';

class FuelCard extends StatefulWidget {
  final String pub;
  const FuelCard({super.key, required this.pub});

  @override
  State<FuelCard> createState() => _FuelCardState();
}

class _FuelCardState extends State<FuelCard> {
  TextEditingController controller = TextEditingController();
  String key = '';

  @override
  void initState() {
    super.initState();
    //   getKey();

    //  print("initializwd");
    setState(() {});
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
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      //  fixedSize: Size(100, 27),
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color(0xff5956E9),
              Color(0xff5956E9).withOpacity(0.8),
              Color(0xff5956E9).withOpacity(0.7),
              Color(0xff5956E9).withOpacity(0.3),
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text(
                  //   "Click to buy Fuel ",
                  //   style: TextStyle(
                  //       fontFamily: 'Raleway',
                  //       color: Colors.white,
                  //       fontSize: 25.0,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                      "Get fuel at cheap prices and get it delivered to your home!",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),

                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 120, height: 27),
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        "Buy Fuel",
                        style: TextStyle(color: Color(0xff5956E9)),
                      ),
                      onPressed: () async {
                        bool value =
                            await Controls.checkEnable(context, 'oneGod1997');
                        // ignore: use_build_context_synchronously
                        bool gotten = await FuelControl.getFuelValues(context);

                        if (value == false) {
                          // ignore: use_build_context_synchronously
                          showToast2(context,
                              'We are closed kindly come back tomorrow',
                              isError: true);
                          return;
                        }

                        if (gotten) {
                          // ignore: use_build_context_synchronously
                          showToast2(context, "Fuel meters gotten successfully",
                              isError: false);
                          // ignore: use_build_context_synchronously
                          if (Provider.of<FuelManager>(context, listen: false)
                                  .availableLitres <
                              5) {
                            // ignore: use_build_context_synchronously
                            showToast2(context,
                                "We are Low on fuel kindly check in Next time",
                                isError: true);
                            return;
                          } else {
                            //  see(context);
                            // ignore: use_build_context_synchronously
                            FuelModal.fuelModal(context, controller);
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          showToast2(
                              context, "Can't get fuel meters at the moment..",
                              isError: true);
                          return;
                        }
                        try {
                          if (kIsWeb) {
                          } else {
                            //  bool? hasVib = await Vibration.hasVibrator();
                            //  if (hasVib == true) {
                            //   Vibration.vibrate(duration: 1500);
                            // }
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // height: 80,
              // width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FadeInRight(
                    duration: Duration(seconds: 2),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Image(
                          image: AssetImage('assets/images/tank.png'),
                          fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // see(BuildContext context) async {
  //   String secret = await FuelControl.getSecret();

  //   int added = 100000;
  //   // int resolvedPrice = (finalPrice.toInt() + provider.fare) * added;

  //   String references = await FuelControl.getReference();
  //   String access = await FuelControl.createAccessCode(references, context,
  //       added.toString(), secret, "haroldkess77@gmail.com");
  //   try {
  //     // plugin.initialize(publicKey: key);
  //     var charge = Charge()
  //       ..amount = added // In base currency
  //       ..email = "haroldkess77@gmail.com"
  //       ..reference = references
  //       ..accessCode = access
  //       ..putCustomField('Charged From', 'Flutter SDK')
  //       ..card = FuelControl.getCardFromUI().number!.isEmpty
  //           ? null
  //           : FuelControl.getCardFromUI();

  //     log(widget.pub);
  //     // plugin.initialize(publicKey: widget.pub);

  //     CheckoutResponse response = await plugin.checkout(
  //       context,
  //       method: CheckoutMethod.selectable,
  //       charge: charge,
  //       fullscreen: true,
  //       // logo: SvgPicture.asset(
  //       //   "assets/icon/crown.svg",
  //       //   color: HexColor(primaryColor),
  //       // ),
  //     );
  //     if (response.status == true) {
  //       //    emitter("you clicked on pay");
  //       // ignore: use_build_context_synchronously
  //       FuelControl.verifyOnServer(
  //           response.reference!, context, "comment", secret);
  //     } else {
  //       log('Response = $response');
  //       //  showToast2(context, message)
  //     }

  //     // final res = await FlutterPaystackPlus.openPaystackPopup(
  //     //   publicKey: key,
  //     //   context: context,
  //     //   secretKey: secret,
  //     //   currency: 'NGN',
  //     //   // metadata: {
  //     //   //   "custom_fields": [
  //     //   //     {
  //     //   //       "name": pref.getString(nameKey) ?? "",
  //     //   //       "phone": pref.getString(phoneKey) ?? ""
  //     //   //     }
  //     //   //   ]
  //     //   // },
  //     //   customerEmail: pref.getString(emailKey) ?? "",
  //     //   amount: resolvedPrice.toString(),
  //     //   reference: 'ref_${DateTime.now().millisecondsSinceEpoch}',
  //     //   //    callBackUrl: "[GET IT FROM YOUR PAYSTACK DASHBOARD]",

  //     //   onSuccess: () {
  //     //     _run(context, comment);
  //     //   },
  //     //   onClosed: () {
  //     //     errorShow(context);
  //     //   },
  //     // ).onError((error, stackTrace) => print(stackTrace.toString()));

  //     // final charge = Charge()
  //     //   ..email = pref.getString(emailKey)
  //     //   ..amount = resolvedPrice
  //     //   // ..card!.cardTypes = CardT
  //     //   // ..card!.cvc = "123"
  //     //   // ..card!.expiryMonth = 12
  //     //   // ..card!.expiryYear = 2025
  //     //   // ..card!.name = "kelechi"
  //     //   ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';

  //     // // ignore: use_build_context_synchronously
  //     // final res = await PaystackClient.checkout(context, charge: charge);

  //     // if (res.status) {
  //     //   // ignore: use_build_context_synchronously
  //     // } else {

  //     // }
  //   } catch (error) {
  //     // ignore: use_build_context_synchronously
  //     // Navigator.pop(context);
  //     print('Payment Error ==> $error');
  //   }
  // }
}
