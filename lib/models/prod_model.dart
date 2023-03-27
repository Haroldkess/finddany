import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
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
  late String? searchName;
  

  ProductModel({
    this.id,
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
    this.searchName,
     
  });

  factory ProductModel.fromDoc(DocumentSnapshot doc) {
    return ProductModel(
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
        searchName: doc['searchName']);
  }
}
