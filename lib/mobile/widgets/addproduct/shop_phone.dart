import 'package:flutter/material.dart';
import 'package:shoppingyou/service/constant.dart';

class ProductShopPhone extends StatelessWidget {
  final TextEditingController controller;
  const ProductShopPhone({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.phone,
                  size: 24.0, color: kPrimaryColor, semanticLabel: 'ShopPhone'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Shop phone',
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
