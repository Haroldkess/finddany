import 'package:flutter/material.dart';
import 'package:shoppingyou/service/constant.dart';

class ProductShopName extends StatelessWidget {
  final TextEditingController controller;
  const ProductShopName({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.shop,
                  size: 24.0, color: kPrimaryColor, semanticLabel: 'shopname icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'ShopName',
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
