import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/games/wallets/fund_wallet/fund_wallet.dart';
import 'package:shoppingyou/mobile/games/wallets/withdraw_wallet/withdraw_wallet.dart';
import 'package:shoppingyou/mobile/widgets/drawer.dart';

class GameSide extends StatelessWidget {
  const GameSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Games",
              style: TextStyle(
                  fontFamily: 'Raleway',
                  color: const Color.fromARGB(255, 155, 148, 148),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text(
                "Engage and win daily cash prices",
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              AppDrawer.of(context)?.toggle();
            },
            icon:
                const Icon(Icons.segment, color: Color(0xff5956E9), size: 30)),
        actions: const [],
      ),
      body: const Column(
        children: [
          Row(
            children: [
              FundWallet(),
              SizedBox(
                width: 10,
              ),
              WithdrawWallet()
            ],
          )
        ],
      ),
    );
  }
}
