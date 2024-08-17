import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/fuel/fuelcontrol/fuel_control.dart';
import 'package:shoppingyou/mobile/widgets/pop_up.dart';
import 'package:shoppingyou/models/barrel_model.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/firebase_calls.dart';
import 'package:shoppingyou/service/operations.dart';
import 'package:http/http.dart' as http;

class BarrelController extends GetxController {
  static BarrelController get instance {
    return Get.find<BarrelController>();
  }

  Rx<BuyBarrelModel> barrel = BuyBarrelModel().obs;
  Rx<MyBarrelModel> myBarrel = MyBarrelModel().obs;
  RxString type = "".obs;

  RxBool loadPay = false.obs;

  changeType(String val) {
    type.value = val;
    update();
  }

  getBarrel({bool? referesh}) async {
    if (barrel.value.id != null && referesh != true) return;
    try {
      final data = await FirebaseCalls.getById(
          id: "jD3pJnfohGHgMLvVKDfc", collection: "barrel");
      if (data != null) {
        barrel.value = BuyBarrelModel.fromDoc(data);
      }
      getMyBarrel();
    } catch (e) {
      Operations.debug(e);
    }

    update();
  }

  updateBarrel() async {
    final data = {
      'stock': FieldValue.increment(-1),
    };

    try {
      await FirebaseCalls.updateData(
          id: "jD3pJnfohGHgMLvVKDfc", collection: "barrel", data: data);
    } catch (e) {
      Operations.debug(e);
    }
  }

  addBarrel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final data = getData(
          name: pref.getString(userIdKey)!,
          isFull: false,
          returns: 0.0,
          barrelOwned: 1,
          invested: 0.0);
      await FirebaseCalls.setData(
          id: data.name!, collection: "my_barrels", data: data.toJson());
      addHistory(
          barrel.value.price.toString(), "New Barrel Purchase", "Barrel");

      updateBarrel();
    } catch (e) {
      Operations.debug(e);
    }
  }

  addHistory(String? amount, String? desc, String? type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final data = {
        "amount": amount,
        "description": desc,
        "type": type,
        "created": Timestamp.now()
      };
      await FirebaseCalls.setDataDoubleCollection(
          id: pref.getString(userIdKey)!,
          collections: ["users", "barrel_history"],
          data: data);

      //  updateBarrel();
    } catch (e) {
      Operations.debug(e);
    }
  }

  // getHistory ()async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   try {
  //     final data = await FirebaseCalls.get(
  //         id: pref.getString(userIdKey)!, collection: "my_barrels");
  //     if (data != null) {
  //       myBarrel.value = MyBarrelModel.fromDoc(data);
  //     }
  //   } catch (e) {
  //     Operations.debug(e);
  //   }

  //   update();

  // }

  repairBarrel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final data = {
        'created': Timestamp.now(),
        'expires':
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 90))),
        'repaired': true,
      };

      await FirebaseCalls.updateData(
          id: pref.getString(userIdKey)!, collection: "my_barrels", data: data);

      addHistory(
          barrel.value.repair.toString(), "Barrel Maintainance", "Barrel");
      getMyBarrel();

      AppSnackBar.snackBar(
          message: "Barrel repaired", head: "Repaired", isError: false);
    } catch (e) {
      Operations.debug(e);
    }
  }

  refillBarrel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final data = {
        'isFull': true,
        'invested': (barrel.value.perLitre! * barrel.value.litre!).toDouble(),
        'liters': 50,
        'paid': true,
      };

      await FirebaseCalls.updateData(
          id: pref.getString(userIdKey)!, collection: "my_barrels", data: data);
      getMyBarrel();

      AppSnackBar.snackBar(
          message: "Barrel full", head: "Refill", isError: false);
      update();
    } catch (e) {
      Operations.debug(e);
    }
  }

  getMyBarrel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final data = await FirebaseCalls.getById(
          id: pref.getString(userIdKey)!, collection: "my_barrels");
      if (data != null) {
        myBarrel.value = MyBarrelModel.fromDoc(data);
      }
    } catch (e) {
      Operations.debug(e);
    }

    update();
  }

  MyBarrelModel getData(
      {double? invested,
      double? returns,
      String? name,
      bool? isFull,
      int? barrelOwned}) {
    MyBarrelModel data = MyBarrelModel(
      id: barrel.value.id,
      litre: 0,
      price: barrel.value.price,
      name: name,
      created: Timestamp.now(),
      expires: Timestamp.fromDate(DateTime.now().add(const Duration(days: 90))),
      refill: 0,
      isFull: isFull,
      invested: invested,
      hasExpired: false,
      returns: returns,
      barrelOwned: 1,
      paid: false,
      finalExpiration:
          Timestamp.fromDate(DateTime.now().add(const Duration(days: 270))),
      repaired: true,
    );

    return data;
  }

  isLoading(bool val) {
    loadPay.value = val;
    update();
  }

  Future<void> makePayment(
    BuildContext context,
    int price,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLoading(true);

    String key = await FuelControl.getKey();

    String secret = await FuelControl.getSecret();

    int added = 100;
    int resolvedPrice = price * added;

    final references = await FuelControl.getReference();

    try {
      Operations.debug("here ui is a access code $references");

      await FlutterPaystackPlus.openPaystackPopup(
        publicKey: key,
        // ignore: use_build_context_synchronously
        context: context,
        secretKey: secret,
        currency: 'NGN',
        customerEmail: pref.getString(emailKey) ?? "",
        amount: resolvedPrice.toString(),
        reference: references,
        onSuccess: () {
          verifyOnServer(references, secret);
        },
        onClosed: () {
          verifyOnServer(references, secret);
        },
      );
    } catch (error) {
      isLoading(false);

      Operations.debug('Payment Error ==> $error');
    }
    isLoading(false);

    isLoading(false);
  }

  Future makePaymentMobile(context, int price) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLoading(true);

    // ignore: unused_local_variable
    String key = await FuelControl.getKey();

    String secret = await FuelControl.getSecret();
    int added = 100;
    int resolvedPrice = price * added;
    final references = await FuelControl.getReference();
    final request = PaystackTransactionRequest(
      reference: references,
      secretKey: secret,
      email: pref.getString(emailKey)!,
      amount: double.tryParse(resolvedPrice.toString())!,
      currency: PaystackCurrency.ngn,
      channel: [
        PaystackPaymentChannel.mobileMoney,
        PaystackPaymentChannel.card,
        PaystackPaymentChannel.ussd,
        PaystackPaymentChannel.bankTransfer,
        PaystackPaymentChannel.bank,
        PaystackPaymentChannel.qr,
        PaystackPaymentChannel.eft,
      ],
    );

    try {
      final initializedTransaction =
          await PaymentService.initializeTransaction(request);

      if (!initializedTransaction.status) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(initializedTransaction.message),
        ));

        return;
      }

      final PaystackTransactionVerified response =
          await PaymentService.showPaymentModal(context,
                  transaction: initializedTransaction,
                  // Callback URL must match the one specified on your paystack dashboard,
                  callbackUrl: '...')
              .then((_) async {
        return await PaymentService.verifyTransaction(
          paystackSecretKey: secret,
          initializedTransaction.data?.reference ?? request.reference,
        );
      });

      if (response.data.status == PaystackTransactionStatus.success) {
        verifyOnServer(references, secret);
      } else {
        verifyOnServer(references, secret);
      }
    } catch (error) {
      isLoading(false);
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      Operations.debug('Payment Error ==> $error');
    }
    isLoading(false);

    isLoading(false);
  }

  verifyOnServer(String reference, String sk) async {
    try {
      Operations.debug("verifying");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $sk'
      };

      Operations.debug("calling");
      http.Response response = await http
          .get(
              Uri.parse(
                  'https://api.paystack.co/transaction/verify/$reference'),
              headers: headers)
          .timeout(const Duration(seconds: 30));
      final Map body = json.decode(response.body);
      Operations.debug(response.body);
      if (body['data']['status'] == 'success') {
        Operations.debug("paid");

        if (type.value == "buy") {
          await addBarrel();
        } else if (type.value == "repair") {
          await repairBarrel();
        } else {
          await refillBarrel();
        }
      } else {
        Operations.debug("unpaid");

        AppSnackBar.snackBar(
            message: "Payment failed",
            head: "Payment unverified",
            isError: true);
      }

      //do something with the response. show success}
      //show error prompt}
    } catch (e) {
      AppSnackBar.snackBar(
          message: "Payment failed: $e", head: "Payment failed", isError: true);
      Operations.debug(e);
      return;
    }
  }
}
