import 'package:cloud_firestore/cloud_firestore.dart';

class FuelModel {
  late String? address;
  late String? comment;
  late String? email;
  late String? id;
  late String? userId;
  late int? litres;
  late String? location;
  late String? name;
  late String? phone;
  late int? price;
  late bool? recieved;
  late Timestamp? timestamp;

  FuelModel({
    this.address,
    this.comment,
    this.email,
    this.id,
    this.userId,
    this.litres,
    this.location,
    this.name,
    this.phone,
    this.price,
    this.recieved,
    this.timestamp,
  });

  factory FuelModel.fromDoc(DocumentSnapshot doc) {
    return FuelModel(
      id: doc.id,
      address: doc["address"],
      comment: doc["comment"],
      email: doc["email"],
      userId: doc["id"],
      litres: doc["litres"],
      location: doc["location"],
      name: doc["name"],
      phone: doc["phone"],
      price: doc["price"],
      recieved: doc["recieved"],
      timestamp: doc["timestamp"],
    );
  }
}
