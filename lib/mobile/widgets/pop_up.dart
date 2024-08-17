import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingyou/mobile/widgets/text.dart';

class AppSnackBar {
  static snackBar(
      {required String message,
      required String head,
      required bool isError,
      Duration? duration}) {
    Get.snackbar(head, message,
        snackStyle: SnackStyle.FLOATING,
        titleText: AppText(
          text: head,
          color: Colors.white,
        ),
        messageText: AppText(
          text: message,
          color: Colors.white,
        ),
        isDismissible: true,
        duration: duration ?? const Duration(seconds: 4),
        showProgressIndicator: true,
        snackPosition: SnackPosition.TOP,
        backgroundColor: isError ? Colors.red : Colors.blue[900],
        colorText: Colors.white);
  }
}
