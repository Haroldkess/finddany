// ignore_for_file: use_build_context_synchronously
// import 'package:paystack_manager_package/paystack_pay_manager.dart';

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';
// import 'package:flutter_paystack_client/flutter_paystack_client.dart'
//     hide context;
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
// import 'package:pay_with_paystack/pay_with_paystack.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/fuel_manager.dart';
// import 'package:vibration/vibration.dart';

//final plugin = PaystackPayment();

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
        // log(value.data()!["price"].toString());
        // log(value.data()!["maxlitres"].toString());
        // log(value.data()!["minlitres"].toString());
        // log(value.data()!["litres"].toString());
        // log(value.data()!["fare"].toString());
        fuel.addLitreValues(
            value.data()!["price"],
            value.data()!["maxlitres"],
            value.data()!["minlitres"],
            value.data()!["litres"],
            value.data()!["fare"]);
      }).whenComplete(() => isFinished = true);
    } catch (e) {
      log(e.toString());
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
          "Delivery": pref.getString(deliveryKey) ?? "",
          "phone": pref.getString(phoneKey),
          "email": pref.getString(emailKey),
          "address": "${pref.getString(addressKey)}",
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
              "Delivery": pref.getString(deliveryKey) ?? "",
              "phone": pref.getString(phoneKey),
              "email": pref.getString(emailKey),
              "address": "${pref.getString(addressKey)}",
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
      log(e.toString());
    }
    return isFinished;
  }

  static _run(BuildContext context, String comment) async {
    FuelManager provider = Provider.of<FuelManager>(context, listen: false);
    bool sendOrder =
        await pumpFuel(context, provider.selectedLires.toInt(), comment);
    if (sendOrder) {
      provider.isLoading(false);
      Controls.fuelHistoryController(context);
      // ignore: use_build_context_synchronously
      //  Navigator.pop(context);
      // showToast(
      //     'Charge was successful. Ref: ${res.reference}', successBlue);
      showToast2(context, 'Order Completed successfully ', isError: false);
      Navigator.pop(context);
    } else {
      showToast2(context, 'waiting for network do not Exit page  ',
          isError: false);
      // ignore: use_build_context_synchronously
      bool sendOrder =
          await pumpFuel(context, provider.selectedLires.toInt(), comment);
      if (sendOrder) {
        provider.isLoading(false);
        // ignore: use_build_context_synchronously
        Controls.fuelHistoryController(context);
        // showToast2(context,
        //     'Charge was successful. Ref: ${res.reference}', isError: false);
        showToast2(context, 'Order Completed successfully ', isError: false);
        Navigator.pop(context);
      } else {
        showToast2(context, 'Order failed or pending ', isError: true);
      }
    }

    // try {
    //   if (kIsWeb) {
    //   } else {
    //     bool? hasVib = await Vibration.hasVibrator();
    //     if (hasVib == true) {
    //       Vibration.vibrate(duration: 1500);
    //     }
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  // static PaymentCard getCardFromUI() {
  //   // Using just the must-required parameters.
  //   return PaymentCard(
  //     number: "",
  //     cvc: "",
  //     expiryMonth: 0,
  //     expiryYear: 0,
  //   );
  // }

  // static buildPaystackPayManager(
  //     BuildContext context, key, ref, amount, email, name) {
  //   return PaystackPayManager(
  //     context: context,
  //     secretKey: key,
  //     reference: ref,
  //     amount: amount,
  //     country: 'Nigeria',
  //     currency: 'NGN',
  //     email: email,
  //     firstName: name,
  //     lastName: '',
  //     companyAssetImage: null,
  //     metadata: {},
  //     onSuccessful: (t) {},
  //     onPending: (t) {},
  //     onFailed: (t) {},
  //     onCancelled: (t) {},
  //   ).initialize();
  // }

  static Future<void> makePayment(
    BuildContext context,
    String comment,
  ) async {
    FuelManager provider = Provider.of<FuelManager>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    double finalPrice = provider.selectedLires * provider.sellingPrice;

    provider.isLoading(true);

    String key = await getKey();

    String secret = await getSecret();

    int added = 100;
    int resolvedPrice = (finalPrice.toInt() + provider.fare) * added;

    final references = await getReference();
    // String access = await createAccessCode(references, context,
    //     resolvedPrice.toString(), secret, pref.getString(emailKey) ?? "");
    try {
      log("here ui is a access code $references");

      // var charge = Charge()
      //   ..amount = resolvedPrice // In base currency
      //   ..email = pref.getString(emailKey) ?? ""
      //   ..reference = references
      //   ..accessCode = access
      //   ..putCustomField('Charged From', 'Flutter SDK')
      //   ..card = getCardFromUI().number!.isEmpty ? null : getCardFromUI();

      // final plugin = PaystackPayment();
      // plugin.initialize(publicKey: key);

      // CheckoutResponse response = await plugin.checkout(
      //   context,
      //   method: CheckoutMethod.selectable,
      //   charge: charge,
      //   fullscreen: true,
      //   // logo: SvgPicture.asset(
      //   //   "assets/icon/crown.svg",
      //   //   color: HexColor(primaryColor),
      //   // ),
      // );

      // buildPaystackPayManager(context, key, references, resolvedPrice,
      //     pref.getString(emailKey), pref.getString(nameKey));
      // if (response.status == true) {
      //   //    emitter("you clicked on pay");
      //   // ignore: use_build_context_synchronously
      //   verifyOnServer(response.reference!, context, comment, secret);
      // } else {
      //   log('Response = $response');
      //   //  showToast2(context, message)
      // }

      await FlutterPaystackPlus.openPaystackPopup(
        publicKey: key,
        context: context,
        secretKey: secret,
        currency: 'NGN',
        // metadata: {
        //   "custom_fields": [
        //     {
        //       "name": pref.getString(nameKey) ?? "",
        //       "phone": pref.getString(phoneKey) ?? ""
        //     }
        //   ]
        // },
        customerEmail: pref.getString(emailKey) ?? "",
        amount: resolvedPrice.toString(),
        reference: references,
        //    callBackUrl: "[GET IT FROM YOUR PAYSTACK DASHBOARD]",

        onSuccess: () {
          verifyOnServer(references, context, comment, secret);
        },
        onClosed: () {
          //  print("closed");
          verifyOnServer(references, context, comment, secret);
          //   errorShow(context);
        },
      );

      // final charge = Charge()
      //   ..email = pref.getString(emailKey)
      //   ..amount = resolvedPrice
      //   // ..card!.cardTypes = CardT
      //   // ..card!.cvc = "123"
      //   // ..card!.expiryMonth = 12
      //   // ..card!.expiryYear = 2025
      //   // ..card!.name = "kelechi"
      //   ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';

      // // ignore: use_build_context_synchronously
      // final res = await PaystackClient.checkout(context, charge: charge);

      // if (res.status) {
      //   // ignore: use_build_context_synchronously
      // } else {

      // }
    } catch (error) {
      provider.isLoading(false);
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      print('Payment Error ==> $error');
    }
    provider.isLoading(false);
    // ignore: use_build_context_synchronously
    //  Navigator.pop(context);
    provider.isLoading(false);
  }

  static Future makePaymentMobile(BuildContext context, String comment) async {
    FuelManager provider = Provider.of<FuelManager>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    double finalPrice = provider.selectedLires * provider.sellingPrice;

    provider.isLoading(true);

    String key = await getKey();

    String secret = await getSecret();
    int added = 100;
    int resolvedPrice = (finalPrice.toInt() + provider.fare) * added;
    final references = await getReference();
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
        verifyOnServer(references, context, comment, secret);
      } else {
        verifyOnServer(references, context, comment, secret);
      }
    } catch (error) {
      provider.isLoading(false);
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      print('Payment Error ==> $error');
    }
    provider.isLoading(false);
    // ignore: use_build_context_synchronously
    //  Navigator.pop(context);
    provider.isLoading(false);
  }

  static Future<String> createAccessCode(
      reference, context, String amount, String sk,
      [String? email]) async {
    // skTest -> Secret key
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $sk'
    };
    Map data = {
      "amount": amount,
      "email": "$email",
      //"plan": "PLN_ojmkb58irexmavd",
      "reference": reference,
    };

    String payload = json.encode(data);
    http.Response response = await http
        .post(Uri.parse('https://api.paystack.co/transaction/initialize'),
            headers: headers, body: payload)
        .timeout(const Duration(seconds: 30));
    var data2 = jsonDecode(response.body);
    // print(data2.toString());
    String accessCode = data2['data']['access_code'];
    String authUrl = data2['data']['authorization_url'];
    return authUrl;
  }

  static Future<String> getReference() async {
    late String ret;
    String platform;
    if (kIsWeb) {
      platform = 'WEB';
    } else if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    ret =
        'ChargedFrom${platform}quickly${DateTime.now().millisecondsSinceEpoch.toString()}';

    return ret;
  }

  static errorShow(context) {
    FuelManager provider = Provider.of<FuelManager>(context, listen: false);

    provider.isLoading(false);
    // ignore: use_build_context_synchronously
    //   Navigator.pop(context);
    // ignore: use_build_context_synchronously
    showToast2(context, 'Failed: ', isError: true);
  }

  static Future getKey() async {
    late String? key;
    await FirebaseFirestore.instance
        .collection("controls")
        .doc('oneGod1997')
        .get()
        .then((value) {
      key = value.data()!["key"];
    });

    return key ?? "";

    //await PaystackClient.initialize(key);
  }

  static Future getSecret() async {
    late String? key;
    await FirebaseFirestore.instance
        .collection("controls")
        .doc('oneGod1997')
        .get()
        .then((value) {
      key = value.data()!["secret"];
    });

    return key ?? "";

    //await PaystackClient.initialize(key);
  }

  static verifyOnServer(
      String reference, context, String comment, String sk) async {
    try {
      log("verifying");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $sk'
      };

      log("calling");
      http.Response response = await http
          .get(
              Uri.parse(
                  'https://api.paystack.co/transaction/verify/$reference'),
              headers: headers)
          .timeout(const Duration(seconds: 30));
      final Map body = json.decode(response.body);
      log(response.body);
      if (body['data']['status'] == 'success') {
        log("paid");

        _run(context, comment);
      } else {
        log("unpaid");
        errorShow(context);
      }

      //do something with the response. show success}
      //show error prompt}
    } catch (e) {
      errorShow(context);
      print(e);
      return;
    }
  }
}
