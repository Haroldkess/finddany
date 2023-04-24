import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/allNavigation.dart';
import 'package:shoppingyou/mobile/admin/users_that_ordered.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/models/ui_model.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/controller.dart';

import '../../service/state/fuel_manager.dart';
import '../fuel/fuelcontrol/fuel_control.dart';
import '../screens/addProduct.dart';
import 'admin_fuel_orders.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController? fare;
  TextEditingController? minLitres;
  TextEditingController? maxLitres;
  TextEditingController? price;
  TextEditingController? litres;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FuelManager fuel = Provider.of<FuelManager>(context, listen: false);
      bool gotten = await FuelControl.getFuelValues(context);

      if (gotten) {
        fare = TextEditingController(text: fuel.fare.toString());
        minLitres = TextEditingController(text: fuel.minLitres.toString());
        maxLitres = TextEditingController(text: fuel.maxLitres.toString());
        price = TextEditingController(text: fuel.sellingPrice.toString());
        litres = TextEditingController(text: fuel.availableLitres.toString());
      } else {
        fare = TextEditingController();
        minLitres = TextEditingController();
        maxLitres = TextEditingController();
        price = TextEditingController();
        litres = TextEditingController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Welcome Admin",
            textScaleFactor: 1.5,
            style: TextStyle(
                color: Colors.blue.shade900, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, 'homeScreen');
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xff5956E9),
                )),
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.15,
              //   child: Row(
              //     children: [
              //       Text(
              //         "Welcome Admin",
              //         textScaleFactor: 1.5,
              //         style: TextStyle(
              //             color: Colors.blue.shade900,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       const SizedBox(height: 10),
              //     ],
              //   ),
              // ),
              Expanded(
                child: GridView.builder(
                    itemCount: dashboard.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isDesktop(context)
                          ? 5
                          : Responsive.isTablet(context)
                              ? 3
                              : 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      //   mainAxisExtent: 5,
                    ),
                    itemBuilder: (context, index) {
                      AdminDasboard model = dashboard[index];
                      return InkWell(
                        onTap: () async {
                          if (model.id == 0) {
                            PageRouting.pushToPage(
                                context, const AdminOrderPage());
                          } else if (model.id == 4) {
                            bool value = await Controls.checkEnable(
                                context, 'oneGod1997');
                            // ignore: use_build_context_synchronously
                            if (value) {
                              Modals.enableModal(context, "oneGod1997", false);
                            } else {
                              Modals.enableModal(context, "oneGod1997", true);
                            }
                          } else if (model.id == 6) {
                            PageRouting.pushToPage(context, const AddProduct());
                          } else if (model.id == 7) {
                            PageRouting.pushToPage(
                                context, const AdminFuelOrders());
                          } else if (model.id == 8) {
                            Modals.adjustFuelMeter(context, price!, fare!,
                                litres!, maxLitres!, minLitres!);
                          }
                        },
                        child: Container(
                          //height: 100,
                          color: Colors.grey.shade400,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  model.icon,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  model.title,
                                  style: const TextStyle(
                                      color: Color(0xff5956E9), fontSize: 23),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
