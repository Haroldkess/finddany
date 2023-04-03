import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';

import '../../service/state/ui_manager.dart';

class CustomPassword extends StatelessWidget {
  const CustomPassword({Key? key}) : super(key: key);

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
              Icon(Icons.lock_outline,
                  size: 24.0, color: Colors.grey, semanticLabel: 'Email icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Passcode',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString(passwordKey, value);
              log(_provider.pref!.getString(passwordKey).toString());
            },
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: TextButton(
                    onPressed: () {
                      _provider.showPassword
                          ? _provider.showPass(false)
                          : _provider.showPass(true);
                    },
                    child: Text("Show")),
                suffixStyle: const TextStyle(color: Color(0xff5956E9))),
            obscureText: context.watch<UiProvider>().showPassword ? false :  true,
          )
        ],
      ),
    ));
  }
}
