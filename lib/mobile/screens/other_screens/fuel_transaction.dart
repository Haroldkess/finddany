import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/mobile/fuel/model/fuel_model.dart';
import 'package:shoppingyou/service/operations.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class FuelTransaction extends StatelessWidget {
  const FuelTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    UiProvider fuel = context.watch<UiProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Fuel Transactions',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontFamily: 'Raleway',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          fuel.fuelOrders.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.hourglass_empty_outlined,
                      color: Colors.blue.shade900,
                      size: 32,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'No Recent Fuel Transactions for Now!!',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : Column(
                  children: [
                    ...fuel.fuelOrders.map((e) => TransactionView(
                          fuel: e,
                        ))
                  ],
                )
        ],
      ),
    );
  }
}

class TransactionView extends StatelessWidget {
  final FuelModel fuel;
  const TransactionView({super.key, required this.fuel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: fuel.recieved!
                        ? Colors.green.withOpacity(.3)
                        : Colors.red.withOpacity(.3)),
                child: Center(
                  child: Icon(
                    fuel.recieved!
                        ? Icons.call_received
                        : Icons.gas_meter_outlined,
                    size: 10,
                    color: fuel.recieved! ? Colors.green : Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${fuel.litres} Liters",
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    Operations.convertDate(fuel.timestamp!.toDate()),
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
          Text(
            "${currencySymbol()}${Operations.convertToCurrency((fuel.price)! * (fuel.litres)!)}",
            style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
