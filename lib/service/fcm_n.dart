// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController {
  static Future requestPermission() async {
    if (kIsWeb) return;
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("access granted");
      // await getToken();
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      // await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
        // For displaying the notification as an overlay
        //   print(message!.notification!.toMap());
        if (message == null) return;
        if (message.notification == null) return;
        if (message.notification != null) {
          if (message.notification!.title != null &&
              message.notification!.body != null) {
            showSimpleNotification(
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/quikliy_icon.png",
                            ))),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.colorDodge,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(.0),
                            Colors.black.withOpacity(.1),
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(.5),
                            Colors.black.withOpacity(.6),
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.3,
                            0.8,
                            0.9
                          ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(message.notification!.body!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              // ignore: deprecated_member_use
              slideDismiss: true,

              elevation: 0,
              background: Colors.blue[900],
              duration: const Duration(seconds: 3),
            );

            // showToast2(context,
            //     "${message.notification!.title} \n\n${message.notification!.body!}",
            //     isError: false);
          }
        }
      });
      // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //   // Handle the incoming message when the app is in the background or terminated
      //   handleNotification(message.data);
      // });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("user granteed provitional access");
    } else {
      debugPrint("user denied access");
    }
  }

  static void handleNotification(Map<String, dynamic> data) {
//    log("data =>  " + data.toString());

    ///Extract custom data
    String notificationType = data['notification_type'];
    String targetPage = data['target_page'];
    //  log("Notification type =>  " + notificationType);
    // log("Target page =>  " + targetPage);

    // Navigate based on notification type
    // if (notificationType == 'post') {
    //   // Navigate to a specific page
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     navigatorKey.currentState?.pushNamed('/post', arguments: targetPage);
    //   });
    // } else if (notificationType == "user") {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     navigatorKey.currentState?.pushNamed('/profile', arguments: targetPage);
    //   });
    // } else if (notificationType == "chat") {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     PersistentNavController.instance.changePersistentTabIndex();
    //   });
    // }

    //   //  Navigator.pushNamed(context, '/$targetPage');
    //   //Get.toNamed(page, preventDuplicates: true);
    // }
  }

  static Future<String> getToken() async {
    late String _token;

    try {
      await FirebaseMessaging.instance.getToken().then((token) async {
        _token = token!;
        await saveToken(token);
      });
    } catch (e) {
      _token = "";
    }

    return _token;
  }

  static Future saveToken(String token) async {
    debugPrint("the token is $token");
    SharedPreferences pref = await SharedPreferences.getInstance();

    //  await pref.setString(deviceTokenKey, token);
  }

  static Future _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
  }
}
