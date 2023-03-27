import 'package:flutter/material.dart';

class ProductStock extends StatelessWidget {
  final TextEditingController controller;
  const ProductStock({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
    children: <Widget>[
      Row(
        children: const [
          Icon(Icons.numbers_outlined,
              size: 24.0, color: Colors.blue, semanticLabel: 'Stock icon'),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Quantity',
              style: TextStyle(color: Colors.blue, fontSize: 16.0),
            ),
          ),
        ],
      ),
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        
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
