import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

const String nameKey = 'name';
const String phoneKey = 'phone';
const String addressKey = 'address';
const String hasShopKey = 'hasShop';
const String countryKey = 'country';
const String stateKey = 'state';
const String dpKey = 'dp';
const String notificationKey = 'notif';

String emailKey = 'email';
String userIdKey = 'id';
String passwordKey = 'password';
String errorRed = '#d60d0d';
String successBlue = '#00008b';

String appName = 'Findd';

const Color kPrimaryColor = Color(0xff5956E9);

FirebaseFirestore collection = FirebaseFirestore.instance;

final userDir = collection.collection('users');
final productDir = collection.collection('products');
final queryDir = collection.collection('query');
final adminOrdersDir = collection.collection('adminOrder');
final historyDir = collection.collection('history');
final categoryDir = collection.collection('category');
final storageRef = FirebaseStorage.instance.ref();
