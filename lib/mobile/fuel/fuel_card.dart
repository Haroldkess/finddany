import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/fuel/fuelcontrol/fuel_control.dart';
import 'package:shoppingyou/mobile/fuel/fuelmodals/fuel_modal.dart';
import 'package:shoppingyou/mobile/widgets/button.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';

import '../../service/controller.dart';

class FuelCard extends StatefulWidget {
  const FuelCard({super.key});

  @override
  State<FuelCard> createState() => _FuelCardState();
}

class _FuelCardState extends State<FuelCard> {
  TextEditingController controller = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.white,
      textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      "Buy fuel at cheap prices and get it delivered to your home!",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),

                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 70, height: 27),
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        "Buy",
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
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              width: 80,
              child: const Image(
                  image: AssetImage('assets/images/tank.png'),
                  fit: BoxFit.contain),
            )
          ],
        ),
      ),
    );
  }
}
