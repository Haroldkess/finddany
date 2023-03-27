import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  late String? id;
  late String? name;
  late String? userId;
  late List<dynamic>? images;
  late String? description;
  late String? price;
  late String? oldPrice;
  late int? stock;
  late List<dynamic>? color;
  late List<dynamic>? size;
  late String? category;
  late int? quantity;
  late String? ShopId;
  late String? address;
  late String? buyerName;
  late String? email;
  late String? phone;
  late bool? recieved;
  late String? shopName;
  late String? shopPhoneNumber;

  OrderModel(
      {this.id,
      required this.name,
      required this.userId,
      required this.images,
      required this.description,
      required this.price,
      required this.oldPrice,
      required this.stock,
      required this.color,
      required this.size,
      required this.category,
      this.quantity,
      this.ShopId,
      this.address,
      this.buyerName,
      this.email,
      this.phone,
      this.recieved,
      required this.shopName,
      required this.shopPhoneNumber});

  factory OrderModel.fromDoc(DocumentSnapshot doc) {
    return OrderModel(
        id: doc.id,
        name: doc['name']!,
        userId: doc['userId'],
        images: doc['images'],
        description: doc['description'],
        price: doc["price"],
        oldPrice: doc['oldPrice'],
        stock: doc["stock"],
        color: doc["color"],
        size: doc['size'],
        category: doc['category'],
        quantity: doc['quantity'],
        ShopId: doc['ShopId'],
        address: doc['address'],
        buyerName: doc['buyerName'],
        email: doc['email'],
        phone: doc['phone'],
        recieved: doc['recieved'],
        shopName: doc['shopName'],
        shopPhoneNumber: doc['shopPhoneNumber']);
  }
}

class AdminOrderUserId {
  late String? id;


  AdminOrderUserId({required this.id,});

  factory AdminOrderUserId.fromDoc(DocumentSnapshot doc) {
    return AdminOrderUserId(id: doc.id);
  }
}

class AdminOrderModel {
  late String? id;
  late String? name;
  late String? userId;
  late List<dynamic>? images;
  late String? description;
  late String? price;
  late String? oldPrice;
  late int? stock;
  late List<dynamic>? color;
  late List<dynamic>? size;
  late String? category;
  late int? quantity;
  late String? ShopId;
  late String? address;
  late String? buyerName;
  late String? email;
  late String? phone;
  late bool? recieved;
  late String? shopName;
  late String? shopPhoneNumber;
  late Timestamp? timestamp;

  AdminOrderModel(
      {this.id,
      required this.name,
      required this.userId,
      required this.images,
      required this.description,
      required this.price,
      required this.oldPrice,
      required this.stock,
      required this.color,
      required this.size,
      required this.category,
      this.quantity,
      this.ShopId,
      this.address,
      this.buyerName,
      this.email,
      this.phone,
      this.recieved,
      required this.shopName,
      required this.shopPhoneNumber,
      this.timestamp});

  factory AdminOrderModel.fromDoc(DocumentSnapshot doc) {
    return AdminOrderModel(
        id: doc.id,
        name: doc['name']!,
        userId: doc['userId'],
        images: doc['images'],
        description: doc['description'],
        price: doc["price"],
        oldPrice: doc['oldPrice'],
        stock: doc["stock"],
        color: doc["color"],
        size: doc['size'],
        category: doc['category'],
        quantity: doc['quantity'],
        ShopId: doc['ShopId'],
        address: doc['address'],
        buyerName: doc['buyerName'],
        email: doc['email'],
        phone: doc['phone'],
        recieved: doc['recieved'],
        shopName: doc['shopName'],
        shopPhoneNumber: doc['shopPhoneNumber'],
        timestamp: doc['timestamp'],);
  }
}
