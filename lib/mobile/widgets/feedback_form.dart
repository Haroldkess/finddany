import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class FeedBackForm extends StatelessWidget {
  final TextEditingController controller;
 final String? name;
  final TextInputType? type;

  const FeedBackForm({Key? key, required this.controller, this.name, this.type }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider _provider = Provider.of<UiProvider>(context);

    return Container(
        child: Padding(
      padding: EdgeInsets.only(top: 45, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: <Widget>[
          Row(
            children:  [
          const    Icon(Icons.gas_meter ,
                  size: 24.0, color: Colors.grey, semanticLabel: 'FeedBack'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                 name ?? 'FeedBack',
                  style: const TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            controller: controller,
            keyboardType: type ?? TextInputType.multiline,
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
