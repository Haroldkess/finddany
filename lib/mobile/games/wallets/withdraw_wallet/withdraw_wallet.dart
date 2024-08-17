import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/games/wallets/extra/wallet_widget.dart';

class WithdrawWallet extends StatelessWidget {
  const WithdrawWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletContainer(
      type: "Withdraw",
      amount: "0.0",
    );
  }
}
