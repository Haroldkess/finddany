import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../designParams/params.dart';
import 'button.dart';
import 'credit_card.dart';

class PaymentModal extends StatelessWidget {
  final int addedPrice;
  const PaymentModal({Key? key, required this.addedPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Confirm and pay',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Products:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF868686),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        context.watch<UiProvider>().cartList.length.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0XFF868686),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
            //  CreditCard(),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 17),
                  ),
                  Row(
                    children: [
                      Text(
                        '${currencySymbol()}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5956E9),
                        ),
                      ),
                      Text(
                        numberFormat.format(int.tryParse(
                            (context.watch<UiProvider>().totalPrice +
                                    addedPrice)
                                .toString())),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5956E9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              context.watch<UiProvider>().loading
                  ? CupertinoActivityIndicator(
                      radius: 30,
                      color: Colors.blue.shade900,
                    )
                  : LargeButton(
                      text: 'Pay now',
                      onClick: () async {
                        await Utility.makePayment(context, addedPrice);
                        Navigator.pop(context);
                      },
                    ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
