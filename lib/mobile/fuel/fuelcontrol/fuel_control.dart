// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart'
    hide context;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';

class FuelControl {
  static Future<bool> getFuelValues(BuildContext context) async {
    late bool isFinished;
    showToast2(context, "Getting Fuel Meters Please wait...", isError: false);
    FuelManager fuel = Provider.of<FuelManager>(context, listen: false);

    try {
      await FirebaseFirestore.instance
          .collection("fuel")
          .doc("oneGod1997")
          .get()
          .then((value) {
        fuel.addLitreValues(
            value.data()!["price"],
            value.data()!["maxlitres"],
            value.data()!["minlitres"],
            value.data()!["litres"],
            value.data()!["fare"]);
      }).whenComplete(() => isFinished = true);
    } catch (e) {
      isFinished = false;
    }

    return isFinished;
  }

  static Future<bool> pumpFuel(
      BuildContext context, int liters, String comment) async {
    late bool isFinished;
    FuelManager fuel = Provider.of<FuelManager>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    showToast2(context, "Fuel Pump is running please wait...", isError: false);

    //fuel.isLoading(true);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction
            .set(FirebaseFirestore.instance.collection("adminFuel").doc(), {
          "id": pref.getString(userIdKey),
          "litres": liters,
          "price": fuel.sellingPrice,
          "location": "",
          "phone": pref.getString(phoneKey),
          "email": pref.getString(emailKey),
          "address": pref.getString(addressKey),
          "timestamp": Timestamp.now(),
          "name": pref.getString(nameKey),
          "comment": comment,
          "recieved": false,
        });
        transaction.set(
            userDir
                .doc(pref.getString(userIdKey))
                .collection("fuelHistory")
                .doc(),
            {
              "id": pref.getString(userIdKey),
              "litres": liters,
              "price": fuel.sellingPrice,
              "location": "",
              "phone": pref.getString(phoneKey),
              "email": pref.getString(emailKey),
              "address": pref.getString(addressKey),
              "timestamp": Timestamp.now(),
              "name": pref.getString(nameKey),
              "comment": comment,
              "recieved": false,
            });
        transaction.update(
            FirebaseFirestore.instance.collection("fuel").doc("oneGod1997"), {
          "litres": FieldValue.increment(-liters),
        });
      }).whenComplete(() async {
        await getFuelValues(context).whenComplete(() => isFinished = true);
        // isFinished = true;
      });
    } catch (e) {
      isFinished = false;
    }
    return isFinished;
  }

  static Future<void> makePayment(BuildContext context, String comment) async {
    FuelManager provider = Provider.of<FuelManager>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    double finalPrice = provider.selectedLires * provider.sellingPrice;

    provider.isLoading(true);
    int added = 100;
    int resolvedPrice = (finalPrice.toInt() + provider.fare) * added;

    try {
      final charge = Charge()
        ..email = pref.getString(emailKey)
        ..amount = resolvedPrice
        // ..card!.cardTypes = CardT
        // ..card!.cvc = "123"
        // ..card!.expiryMonth = 12
        // ..card!.expiryYear = 2025
        // ..card!.name = "kelechi"
        ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';

      // ignore: use_build_context_synchronously
      final res = await PaystackClient.checkout(context, charge: charge);

      if (res.status) {
        // ignore: use_build_context_synchronously
        bool sendOrder =
            await pumpFuel(context, provider.selectedLires.toInt(), comment);
        if (sendOrder) {
          provider.isLoading(false);
          // ignore: use_build_context_synchronously
          //  Navigator.pop(context);
          // showToast(
          //     'Charge was successful. Ref: ${res.reference}', successBlue);
          showToast2(context, 'Order Completed successfully ', isError: false);
        } else {
          showToast2(context, 'waiting for network do not Exit page  ',
              isError: false);
          // ignore: use_build_context_synchronously
          bool sendOrder =
              await pumpFuel(context, provider.selectedLires.toInt(), comment);
          if (sendOrder) {
            provider.isLoading(false);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // showToast2(context,
            //     'Charge was successful. Ref: ${res.reference}', isError: false);
            showToast2(context, 'Order Completed successfully ',
                isError: false);
          }
        }
      } else {
        provider.isLoading(false);
        // ignore: use_build_context_synchronously
        //   Navigator.pop(context);
        // ignore: use_build_context_synchronously
        showToast2(context, 'Failed: ${res.message}', isError: true);
      }
    } catch (error) {
      provider.isLoading(false);
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      print('Payment Error ==> $error');
    }
    provider.isLoading(false);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    provider.isLoading(false);
  }
}
