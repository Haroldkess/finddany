import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future <void> showToast(String message, String color) async {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    webBgColor: color,
    timeInSecForIosWeb: 4,

    textColor: Colors.white,
    fontSize: 16.0,
  );
}
