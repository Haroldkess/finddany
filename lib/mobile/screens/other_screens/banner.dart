import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/screens/barrel/barrel_widget.dart';
import 'package:shoppingyou/mobile/screens/barrel/new_barrel/new_barrel_screen.dart';
import 'package:shoppingyou/mobile/screens/product/singleitemscreen.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/service/controller.dart';

import '../../../service/state/ui_manager.dart';

class BannerHold extends StatelessWidget {
  BannerHold({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 81,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue.shade100,
                  Colors.blue.shade100,
                  Colors.blue.shade100,
                  Colors.blue.shade400,
                ]),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '100% Complete',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 7,
                              width: 191,
                              decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          Text(
                            'Account is completely secure.',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontFamily: 'Raleway',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.shield_moon,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Text(
                'Quick actions',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickActions(
                title: "Fuel Orders",
                icon: Icons.local_gas_station,
                iconColor: Colors.purple,
                tap: () {
                  Navigator.pushNamed(context, 'Fuel');
                },
              ),
              QuickActions(
                title: "Barrel",
                icon: Icons.water_drop,
                iconColor: Colors.white,
                isWater: true,
                tap: () async {
                  BarrelWidgets.buyBarrelSheet(context);
                },
              ),
              QuickActions(
                title: "My Barrel",
                icon: Icons.oil_barrel_outlined,
                iconColor: Colors.brown,
                tap: () {
                  BarrelWidgets.seeBarrelSheet();
                  // Navigator.pushNamed(context, 'deals');
                },
              ),
              QuickActions(
                title: "Quick man",
                icon: Icons.directions_bike,
                iconColor: Colors.green,
                tap: () async {
                  await Utility.launchInWebViewOrVC(Uri.parse(
                      "https://wa.me/+2348070578450/?text=Hello there. i want to make some enquiry from Quickliy."));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  VoidCallback? tap;
  IconData? icon;
  String? title;
  Color? iconColor;
  bool? isWater;

  QuickActions(
      {super.key,
      this.tap,
      this.icon,
      this.iconColor,
      this.title,
      this.isWater});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 96,
        width: 80,
        decoration: BoxDecoration(
            color: isWater == true ? null : Colors.white,
            gradient: isWater == true
                ? LinearGradient(colors: [
                    Colors.brown.shade200,
                    Colors.brown.shade400,
                    Colors.brown.shade600,
                    Colors.brown.shade800
                  ])
                : null,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title ?? "",
              style: TextStyle(
                  color: isWater == true ? Colors.white : Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .5),
            ),
          ],
        ),
      ),
    );
  }
}
