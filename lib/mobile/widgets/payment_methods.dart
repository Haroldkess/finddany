import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class PaymentMethods extends StatefulWidget {
  PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final paymentMethodSelected = 'visa1';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location Type',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 15),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(children: [
                  PaymentMethod(
                    cardNumber: 'Home (10 - 30 min)',
                    radioValue: 'Home',
                    paymenMethodSelected: paymentMethodSelected,
                    //  imagePath: 'assets/images/visa.png',
                  ),
                  PaymentMethod(
                    cardNumber: 'Pick-Up (Pickup before 6pm)',
                    radioValue: 'pickup',
                    paymenMethodSelected: paymentMethodSelected,
                    //   imagePath: 'assets/images/master.png',
                  ),
                  //   PaymentMethod(
                  //     cardNumber: '**** **** **** 8274',
                  //     radioValue: 'bank1',
                  //     paymenMethodSelected: paymentMethodSelected,
                  // //    imagePath: 'assets/images/credit_card.png',
                  //   ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  final String cardNumber;
  final String radioValue;
  final String imagePath;
  final String paymenMethodSelected;
  final Function(String)? onCountChanged;
  PaymentMethod({
    Key? key,
    this.cardNumber = '',
    this.radioValue = '',
    this.imagePath = '',
    this.paymenMethodSelected = '',
    @required this.onCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Radio(
            value: radioValue,
            groupValue: context.watch<UiProvider>().locationType,
            onChanged: (value) async {
              Provider.of<UiProvider>(context, listen: false)
                  .addLocationType(value!);
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image(
          //     image: AssetImage(imagePath),
          //     width: 62,
          //     height: 40,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          const SizedBox(width: 15),
          Text(cardNumber, style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }
}
