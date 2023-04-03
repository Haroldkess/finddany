import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class CustomName extends StatelessWidget {
  const CustomName({Key? key}) : super(key: key);

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
              Icon(Icons.person,
                  size: 24.0, color: Colors.grey, semanticLabel: 'Name icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Name',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString('name', value);
              log( _provider.pref!.getString('name').toString());
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
