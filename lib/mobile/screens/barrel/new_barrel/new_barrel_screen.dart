import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/widgets/text.dart';

class NewBarrelScreen extends StatelessWidget {
  const NewBarrelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            text: "Start your own oil business",
          ),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.oil_barrel,
            color: Colors.brown,
            size: 50,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
