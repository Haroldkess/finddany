import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  late String? name;
  late String? email;
  late String? shopName;
  late String? phoneNumber;
  late String? userLocation;
  late String? shopAddress;
  late String? profileImageUrl;
  late bool? hasShop;

  late String? state;
  late String? country;
  late String? city;
  late bool? verifiedUser;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.shopName,
    this.phoneNumber,
    this.shopAddress,
    this.userLocation,
    this.hasShop = false,
    this.profileImageUrl,
    this.verifiedUser,
    this.country,
    this.city,
    this.state,
  });

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name']!,
      shopName: doc['shopName'],
      email: doc['email'],
      profileImageUrl: doc['profileImageUrl'],
      userLocation: doc["userLocation"],
      phoneNumber: doc['phoneNumber'],
      shopAddress: doc["shopAddress"],
      hasShop: doc["hasShop"],
      verifiedUser: doc['verifiedUser'],
      country: doc['country'],
      city: doc['city'],
    );
  }
}
