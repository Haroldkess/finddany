import 'package:flutter/material.dart';

class ProductOldPrice extends StatelessWidget {
  final TextEditingController controller;
  const ProductOldPrice({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
    children: <Widget>[
      Row(
        children: const [
          Icon(Icons.price_change_outlined,
              size: 24.0, color: Colors.red, semanticLabel: 'old price icon'),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Old Price',
              style: TextStyle(color: Colors.red, fontSize: 16.0),
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
    );
  }
}
