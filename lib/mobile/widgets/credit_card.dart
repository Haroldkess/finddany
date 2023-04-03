import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/state/ui_manager.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0XFFD6D9E0), width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.0),
      // ),
      color: Color(0XFFF4F6FA),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'My credit card',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Image(image: AssetImage('assets/images/visa.png'))
              ],
            ),
            SizedBox(height: 30),
            const Text(
              '**** **** **** ****',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 37),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  <Widget>[
                Text(
                 context.watch<UiProvider>().name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF868686),
                  ),
                ),
               const Text(
                  '04/50',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF868686),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
