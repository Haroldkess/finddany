import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/screens/checkoutdialogues/confirm_change.dart';

Future<void> liveIn(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 5,
              child: const Text(
                "Do you live in Antaress, Okoribi?",
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('yes'),
                    onPressed: () async {
                      Navigator.pop(context);
                      confirmLocation(context);
                    },
                  ),
                  TextButton(
                    child: Text('No'),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
      });
}
