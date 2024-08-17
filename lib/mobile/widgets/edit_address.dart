import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UiProvider provider = Provider.of<UiProvider>(context, listen: false);
      setState(() {
        controller =
            TextEditingController(text: provider.address.split("|||").first);
      });
    });
  }

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
              Icon(Icons.location_on_outlined,
                  size: 24.0,
                  color: Colors.grey,
                  semanticLabel: 'address icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Your address will be for default delivery',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            controller: controller,
            onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString(addressKey, value);
            },
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
