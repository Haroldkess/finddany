import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoppingyou/service/constant.dart';

class WalletContainer extends StatelessWidget {
  final String type;
  final String? amount;
  const WalletContainer({super.key, required this.amount, required this.type});

  @override
  Widget build(BuildContext context) {
    var height = 200.0;
    var width = Get.width;

    return Stack(
      children: [
        Container(
          height: height,
          width: width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: HexColor(successBlue),
          ),
          child: Column(
            children: [
              Text(
                "$type Wallet",
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'Raleway',
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  Text(
                    "${amount ?? 0.0}",
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ).paddingAll(10),
        ),
        Container(
          height: 40,
          width: 20,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20))),
        )
      ],
    );
  }
}
