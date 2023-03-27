import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/state/ui_manager.dart';

class FeedBackForm extends StatelessWidget {
  final TextEditingController controller;
  const FeedBackForm({Key? key, required this.controller}) : super(key: key);

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
                  size: 24.0, color: Colors.grey, semanticLabel: 'FeedBack'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'FeedBack',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            controller:  controller,
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
