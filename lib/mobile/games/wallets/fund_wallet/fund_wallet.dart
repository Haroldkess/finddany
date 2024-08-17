import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/games/wallets/extra/wallet_widget.dart';

class FundWallet extends StatelessWidget {
  const FundWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletContainer(
      type: "Fund",
      amount: "0.0",
    );
  }
}
