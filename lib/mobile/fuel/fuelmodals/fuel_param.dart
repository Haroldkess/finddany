import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/operations.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class FuelParam extends StatelessWidget {
  const FuelParam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FuelManager _provider = Provider.of<FuelManager>(context);
    FuelManager stream = context.watch<FuelManager>();

    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.sell,
                  size: 24.0, color: Colors.grey, semanticLabel: 'Pump'),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'Price Per Litre',
                      style: const TextStyle(
                          color: Color(0xff868686), fontSize: 16.0),
                    ),
                    Text(
                      '${stream.sellingPrice} per Litre',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(Icons.local_gas_station,
                  size: 24.0, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'Available Litres ',
                      style: const TextStyle(
                          color: Color(0xff868686), fontSize: 16.0),
                    ),
                    Text(
                      '${stream.availableLitres} Litres available',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.payment,
                size: 24.0,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'Amount. ',
                      style: const TextStyle(
                          color: Color(0xff868686), fontSize: 16.0),
                    ),
                    Text(
                      '${Operations.convertToCurrency((stream.selectedLires * stream.sellingPrice))} +',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      ' ${Operations.convertToCurrency(stream.fare)}(Fares)',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            child: Slider.adaptive(
              activeColor: Colors.blue.shade900,
              inactiveColor: Colors.black12,
              max: stream.availableLitres <= 75 ? 5 : 5,
              min: 0,
              autofocus: true,
              divisions: stream.availableLitres <= 75 ? 5 : 1,
              label: "${stream.selectedLires.toString()}Litres",
              value: stream.selectedLires,
              onChanged: (val) async {
                _provider.addSelectedLitres(val);
              },
              onChangeStart: (val) {
                _provider.addSelectedLitres(1);
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selected ${stream.selectedLires} Litres",
                style: const TextStyle(
                    color: Color(0xff868686),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class FuelExtra extends StatelessWidget {
  final TextEditingController controller;
  const FuelExtra({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider _provider = Provider.of<UiProvider>(context);

    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.feedback_outlined,
                  size: 24.0, color: Colors.grey, semanticLabel: 'extra'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Extra comment (optional)',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
