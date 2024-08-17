import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class EditPhone extends StatefulWidget {
  const EditPhone({Key? key}) : super(key: key);

  @override
  State<EditPhone> createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UiProvider provider = Provider.of<UiProvider>(context, listen: false);
      setState(() {
        controller = TextEditingController(text: provider.phoneNumber);
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
              Icon(Icons.phone,
                  size: 24.0, color: Colors.grey, semanticLabel: 'phone icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'WhatsApp Number',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString(phoneKey, value);
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
