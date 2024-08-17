import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoppingyou/service/operations.dart';

final firestore = FirebaseFirestore.instance;

class FirebaseCalls {
  static Future setData(
      {required String id,
      required String collection,
      required Map<String, dynamic> data,
      bool? shouldUpdate}) async {
    DocumentSnapshot? documentSnapshot =
        await firestore.collection(collection).doc(id).get();
    if (documentSnapshot.exists) {
      Operations.debug('Document exists');
      if (shouldUpdate == true) {
        await updateData(id: id, collection: collection, data: data);
      } else {
        await firestore.collection(collection).doc(id).set(data);
      }
    } else {
      Operations.debug('Document does not exist setting new data');
      await firestore.collection(collection).doc(id).set(data);
    }
  }

  static Future setDataDoubleCollection(
      {required String id,
      required List<String> collections,
      required Map<String, dynamic> data}) async {
    await firestore
        .collection(collections.first)
        .doc(id)
        .collection(collections.last)
        .doc()
        .set(data);
  }

  static Future setDataDoubleCollectionAndId(
      {required List<String> id,
      required List<String> collections,
      required Map<String, dynamic> data}) async {
    await firestore
        .collection(collections.first)
        .doc(id.first)
        .collection(collections.last)
        .doc(id.last)
        .set(data);
  }

  static Future updateData(
      {required String id,
      required String collection,
      required Map<String, dynamic> data}) async {
    await firestore.collection(collection).doc(id).update(data);
  }

  static Future updateListData(
      {required String id,
      required String collection,
      required Map<String, FieldValue> data}) async {
    await firestore.collection(collection).doc(id).update(data);
  }

  static Future updateDoubleCollectionListData(
      {required List<String> id,
      required List<String> collection,
      required Map<String, FieldValue> data}) async {
    await firestore
        .collection(collection.first)
        .doc(id.first)
        .collection(collection.last)
        .doc(id.last)
        .update(data);
  }

  static Future deleteDoc(
      {required String id,
      required String collection,
      required Map<String, dynamic> data}) async {
    await firestore.collection(collection).doc(id).delete();
  }

  // static Future<SaveUsUser?> getUserById({
  //   required String id,
  //   required String collection,
  // }) async {
  //   SaveUsUser? saveUsUser;
  //   DocumentSnapshot documentSnapshot = await AuthenticationController
  //       .instance.firestore
  //       .collection(collection)
  //       .doc(id)
  //       .get();
  //   if (documentSnapshot.exists) {
  //     saveUsUser = SaveUsUser.fromDoc(documentSnapshot);
  //   } else {
  //     Operations.debug('Document does not exist');
  //   }

  //   return saveUsUser;
  // }

  static Future<DocumentSnapshot> getUserById({
    required String id,
    required String collection,
  }) async {
    DocumentSnapshot? documentSnapshot =
        await firestore.collection(collection).doc(id).get();

    return documentSnapshot;
  }

  static Future<dynamic> getById({
    required String id,
    required String collection,
  }) async {
    late DocumentSnapshot? doc;

    DocumentSnapshot? documentSnapshot =
        await firestore.collection(collection).doc(id).get();
    if (documentSnapshot.exists) {
      doc = documentSnapshot;
    } else {
      doc = null;
      Operations.debug('Document does not exist');
    }

    return doc;
  }

  static Future<String> uploadImage(
          Uint8List file, String storagePath, String contentType) async =>
      await FirebaseStorage.instance
          .ref()
          .child(storagePath)
          .putData(file)
          .then((task) => task.ref.getDownloadURL());
  static Future<String> uploadVideo(
          Uint8List file, String storagePath, String contentType) async =>
      await FirebaseStorage.instance
          .ref()
          .child(storagePath)
          .putData(file)
          .then((task) => task.ref.getDownloadURL());
}
