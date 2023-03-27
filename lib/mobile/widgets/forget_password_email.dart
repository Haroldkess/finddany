import 'package:flutter/material.dart';
import 'package:shoppingyou/service/constant.dart';

class ForgetPasswordEmail extends StatelessWidget {
  final TextEditingController controller;
  const ForgetPasswordEmail({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.email,
                  size: 24.0, color: kPrimaryColor, semanticLabel: 'email icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Email',
                  style: TextStyle(color: kPrimaryColor, fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            controller: controller,
            onChanged: (value) async {},
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
