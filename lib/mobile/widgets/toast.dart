import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


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

showToast2(BuildContext? context, String message, {bool isError = false}) {
  showToastWidget(
      SizedBox(
        width: MediaQuery.of(context!).size.width * 0.9,
        child: Material(
          color: isError ? Colors.white : Colors.blue[900],
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: isError ? Colors.red : Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: isError
                      ? const  Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 42,
                        )
                      : Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                              child: Icon(Icons.notifications_none_outlined , color:   Colors.blue[900],
                          )),
                        ),
                ),
                Expanded(
                  child: Text(
                  message,
                  style: TextStyle(  color: isError ? Colors.red : Colors.white,
                  fontSize:  12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      animation: StyledToastAnimation.slideFromTop,
      duration: const Duration(seconds: 4),
      position:
          const StyledToastPosition(align: Alignment.topCenter, offset: 40.0),
      reverseCurve: Curves.easeInCubic,
      context: context);
}
