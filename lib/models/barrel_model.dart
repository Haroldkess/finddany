import 'package:cloud_firestore/cloud_firestore.dart';

class BuyBarrelModel {
  String? id;
  int? stock;
  int? price;

  int? litre;
  int? repair;
  int? perLitre;

  BuyBarrelModel(
      {this.id,
      this.stock,
      this.litre,
      this.price,
      this.repair,
      this.perLitre});

  factory BuyBarrelModel.fromDoc(DocumentSnapshot doc) {
    return BuyBarrelModel(
      id: doc.id,
      stock: doc['stock'],
      litre: doc['liters'],
      price: doc['price'],
      repair: doc['repair'],
      perLitre: doc['perLiter'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'litre': litre,
        'price': price,
        'stock': stock,
        'repair': repair
      };
}

class MyBarrelModel {
  String? id;
  int? price;
  int? litre;
  String? name;
  Timestamp? created;
  Timestamp? expires;
  bool? isFull;
  int? refill;
  int? barrelOwned;
  double? invested;
  bool? repaired;
  double? returns;
  Timestamp? finalExpiration;
  bool? hasExpired;
  bool? paid;

  MyBarrelModel(
      {this.id,
      this.litre,
      this.price,
      this.name,
      this.created,
      this.expires,
      this.barrelOwned,
      this.hasExpired,
      this.finalExpiration,
      this.isFull,
      this.repaired,
      this.refill,
      this.paid,
      this.invested,
      this.returns});

  factory MyBarrelModel.fromDoc(DocumentSnapshot doc) {
    return MyBarrelModel(
        id: doc.id,
        litre: doc['liters'],
        price: doc['price'],
        name: doc['name'],
        created: doc['created'],
        expires: doc['expires'],
        isFull: doc['isFull'],
        refill: doc['refill'],
        invested: doc['invested'],
        barrelOwned: doc['barrelOwned'],
        returns: doc['returns'],
        finalExpiration: doc['finalExpiration'],
        hasExpired: doc['hasExpired'],
          paid: doc['paid'],
        repaired: doc['repaired']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'liters': litre,
        'price': price,
        'name': name,
        'created': created,
        'expires': expires,
        'finalExpiration': finalExpiration,
        'isFull': isFull,
        'refill': refill,
        'invested': invested,
        'returns': returns,
        'barrelOwned': barrelOwned,
        'hasExpired': hasExpired,
        'repaired': repaired,
        'paid' : paid,
      };
}
