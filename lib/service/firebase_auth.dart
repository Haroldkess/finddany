import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/main.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<bool> signUpUser(BuildContext context) async {
    print('trying to signup');
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    await _provider.initializePref();
    late bool finished;
    try {
      print('try');
      UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(
            email: _provider.getPref.getString(emailKey)!,
            password: _provider.getPref.getString(passwordKey)!,
          )
          .whenComplete(() => print('done'))
          .catchError((e) {
        showToast2(context, e.toString(), isError: true);
        finished = false;
      });
      User signedInUser = authResult.user!;
      if (signedInUser.uid.isNotEmpty) {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction
              .set(_firestore.collection('/users').doc(signedInUser.uid), {
            'id': signedInUser.uid,
            'name': _provider.getPref.getString(nameKey)!,
            'email': _provider.getPref.getString(emailKey)!,
            'shopName': '',
            'phoneNumber': '',
            'userLocation': '',
            'shopAddress': '',
            'profileImageUrl': '',
            'hasShop': false,
            'country': '',
            'state': '',
            'city': '',
            'verifiedUser': false,
          });
        }).whenComplete(() {
          _provider.pref!.setString(passwordKey, '');
          _provider.getPref.setString(userIdKey, signedInUser.uid);
          finished = true;
        }).catchError((e) {
          showToast(e, errorRed);
          finished = false;
        });
      } else {
        finished = false;
      }
    } catch (e) {
      finished = false;
    }

    return finished;
  }

  static Future<bool> logout(context) async {
    late bool finished;

    try {
      _auth.signOut().whenComplete(() {
        finished = true;

        showToast2(context, 'Logged out successfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
            (route) => false);
      }).catchError((e) {
        finished = false;

        showToast2(context, 'Something went wrong ', isError: true);
      });
    } catch (e) {
      finished = false;
      showToast2(context, 'Something went wrong ', isError: true);
    }

    return finished;
  }

  static Future<bool> login(context) async {
    log('here');
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    await _provider.initializePref();
    late bool finished;
    try {
      UserCredential authResult = await _auth
          .signInWithEmailAndPassword(
        email: _provider.getPref.getString(emailKey)!,
        password: _provider.getPref.getString(passwordKey)!,
      )
          .whenComplete(() {
        log('finished');

        _provider.pref!.setString(passwordKey, '');
        finished = true;
      }).catchError((e) {
        showToast(e, errorRed);
        finished = false;
      });
      _provider.getPref.setString(userIdKey, authResult.user!.uid);
    } catch (e) {
      finished = false;
    }

    return finished;
  }

  static Future<bool> runForgetPassword(String email) async {
    late bool finished;

    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .whenComplete(() => finished = true)
          .catchError((e) => finished = false);
    } catch (e) {
      finished = false;
    }

    return finished;
  }
}
