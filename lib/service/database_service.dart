// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:math' hide log;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/mobile/fuel/model/fuel_model.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/models/order_model.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/models/user_model.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/send_fuel_update.dart';

FirebaseFirestore init = FirebaseFirestore.instance;

class DatabaseService {
  static Future<String> uploadPost(Uint8List imageFile) async {
    String photoId = const Uuid().v4();

    final meta = SettableMetadata(contentType: "image/jpg");

    UploadTask uploadTask = storageRef
        .child('productImages/post_$photoId.jpg')
        .putData(imageFile, meta);
    TaskSnapshot storageSnap =
        await uploadTask.whenComplete(() => log("Upload completed"));
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

// post a product
  static Future<bool> postProducts(ProductModel productModel) async {
    late bool finished;
    try {
      await init.runTransaction((transaction) async {
        transaction.set(productDir.doc(), {
          'name': productModel.name,
          'category': productModel.category,
          'color': productModel.color,
          'description': productModel.description,
          'images': productModel.images,
          'oldPrice': productModel.oldPrice,
          'price': productModel.price,
          'size': productModel.size,
          'stock': productModel.stock,
          'userId': productModel.userId,
          'quantity': 0,
          'searchName': productModel.searchName
        });
      }).whenComplete(() async {
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('$e', errorRed);
        
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

// get home product
  static Future<bool> getHomeProduct(
      BuildContext context, bool isCategory) async {
    late bool finished;
    QuerySnapshot homeSnapshot = isCategory
        ? await productDir
            .where('category',
                isEqualTo: Provider.of<UiProvider>(context, listen: false)
                    .homeSelectedCategory)
            .limit(30)
            .get()
            .whenComplete(() {
            finished = true;
          }).catchError((e) {
            finished = false;
          
             showToast2(context, 'Something went wrong you seem to be offline',isError: true);
          })
        : await productDir.limit(30).get().whenComplete(() {
            finished = true;
          }).catchError((e) {
            finished = false;
         
            showToast2(context, 'Something went wrong you seem to be offline',isError: true);
          }).onError((error, stackTrace) async {
            // print(stackTrace.toString());
            return Future.error(Exception(error));
          });
    List<ProductModel> prodPost =
        homeSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    Provider.of<UiProvider>(context, listen: false).addHomeProduct(prodPost);

    log('done with getting prod');
    return finished;
  }

  static Future<bool> getQuickPickProduct(BuildContext context) async {
    late bool finished;
    final _random = Random();
    List<ProductModel> data = [];

    if (Provider.of<UiProvider>(context, listen: false).prod.length > 8) {
      // final data = Provider.of<UiProvider>(context,listen: false).prod.wh
      // final index = Provider.of<UiProvider>(context, listen: false).prod[
      //     _random.nextInt(
      //         Provider.of<UiProvider>(context, listen: false).prod.length)];

      // Provider.of<UiProvider>(context, listen: false)
      //       .prod
      //       .shuffle(_random);
      data.addAll(Provider.of<UiProvider>(context, listen: false).prod);
      data.shuffle(_random);

      Provider.of<UiProvider>(context, listen: false).addQiuckPicks(data);

      finished = true;
    } else {
      finished = false;
    }
    // QuerySnapshot homeSnapshot =
    //     await productDir.orderBy('name').limit(12).get().whenComplete(() {
    //   finished = true;
    // }).catchError((e) {
    //   finished = false;
    //   showToast(e, errorRed);
    // });
    // List<ProductModel> prodPost =
    //     homeSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // // ignore: use_build_context_synchronously
    // Provider.of<UiProvider>(context, listen: false).addQiuckPicks(prodPost);

    // log('done with getting prod');

    return finished;
  }

  static Future<bool> getPopularProduct(BuildContext context) async {
    late bool finished;
    final _random = Random();
    List<ProductModel> data = [];

    if (Provider.of<UiProvider>(context, listen: false).prod.length > 3) {
      // final data = Provider.of<UiProvider>(context,listen: false).prod.wh
      // final index = Provider.of<UiProvider>(context, listen: false).prod[
      //     _random.nextInt(
      //         Provider.of<UiProvider>(context, listen: false).prod.length)];

      // Provider.of<UiProvider>(context, listen: false)
      //       .prod
      //       .shuffle(_random);
      Provider.of<UiProvider>(context, listen: false)
          .prod
          .forEach((element) async {
        if (data.length < 4) {
          data.add(element);
        } else {
          print('skip');
        }
      });

      data.shuffle(_random);

      Provider.of<UiProvider>(context, listen: false).addPopular(data);

      finished = true;
    } else {
      finished = false;
    }
    // QuerySnapshot homeSnapshot =
    //     await productDir.orderBy('category').limit(4).get().whenComplete(() {
    //   finished = true;
    // }).catchError((e) {
    //   finished = false;
    //   showToast(e, errorRed);
    // });
    // List<ProductModel> prodPost =
    //     homeSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // // ignore: use_build_context_synchronously
    // Provider.of<UiProvider>(context, listen: false).addPopular(prodPost);

    // log('done with getting prod');
    return finished;
  }

  static Future<bool> getSliderProduct(BuildContext context) async {
    late bool finished;
    final _random = Random();
    List<ProductModel> data = [];

    if (Provider.of<UiProvider>(context, listen: false).prod.length > 3) {
      // final data = Provider.of<UiProvider>(context,listen: false).prod.wh
      // final index = Provider.of<UiProvider>(context, listen: false).prod[
      //     _random.nextInt(
      //         Provider.of<UiProvider>(context, listen: false).prod.length)];

      // Provider.of<UiProvider>(context, listen: false)
      //       .prod
      //       .shuffle(_random);
      Provider.of<UiProvider>(context, listen: false)
          .prod
          .forEach((element) async {
        if (data.length < 3) {
          data.add(element);
        } else {
          data.shuffle(_random);
        }
      });

      data.shuffle(_random);

      Provider.of<UiProvider>(context, listen: false).addSliderProd(data);

      finished = true;
    } else {
      finished = false;
    }
    // QuerySnapshot homeSnapshot =
    //     await productDir.orderBy('price').limit(3).get().whenComplete(() {
    //   finished = true;
    // }).catchError((e) {
    //   finished = false;
    //   showToast(e, errorRed);
    // });
    // List<ProductModel> prodPost =
    //     homeSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // // ignore: use_build_context_synchronously
    // Provider.of<UiProvider>(context, listen: false).addSliderProd(prodPost);

    // log('done with getting prod');
    return finished;
  }

  static Future<bool> getJustForYouProduct(BuildContext context) async {
    late bool finished;

    final _random = Random();
    List<ProductModel> data = [];

    if (Provider.of<UiProvider>(context, listen: false).prod.length > 3) {
      // final data = Provider.of<UiProvider>(context,listen: false).prod.wh
      // final index = Provider.of<UiProvider>(context, listen: false).prod[
      //     _random.nextInt(
      //         Provider.of<UiProvider>(context, listen: false).prod.length)];

      // Provider.of<UiProvider>(context, listen: false)
      //       .prod
      //       .shuffle(_random);
      Provider.of<UiProvider>(context, listen: false)
          .prod
          .forEach((element) async {
        if (data.length < 3) {
          data.add(element);
        } else {
          print('dont add to just for you');
          //  data.shuffle(_random);
        }
      });

      data.shuffle(_random);

      Provider.of<UiProvider>(context, listen: false).addJustForYou(data);

      finished = true;
    } else {
      finished = false;
    }
    // QuerySnapshot homeSnapshot =
    //     await productDir.orderBy('stock').limit(3).get().whenComplete(() {
    //   finished = true;
    // }).catchError((e) {
    //   finished = false;
    //   showToast(e, errorRed);
    // });
    // List<ProductModel> prodPost =
    //     homeSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // // ignore: use_build_context_synchronously
    // Provider.of<UiProvider>(context, listen: false).addJustForYou(prodPost);

    // log('done with getting prod');
    return finished;
  }

  static Future<UserModel> getUserWithId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString(userIdKey));
    DocumentSnapshot userDocSnapshot =
        await userDir.doc(pref.getString(userIdKey)).get();
    if (userDocSnapshot.exists) {
      return UserModel.fromDoc(userDocSnapshot);
    }
    return UserModel();
  }

  // add to cart
  static Future<bool> addToCart(ProductModel productModel) async {
    late bool finished;
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await init.runTransaction((transaction) async {
        transaction.set(
            userDir
                .doc(pref.getString(userIdKey))
                .collection('cart')
                .doc(productModel.id),
            {
              'name': productModel.name,
              'category': productModel.category,
              'color': productModel.color,
              'description': productModel.description,
              'images': productModel.images,
              'oldPrice': productModel.oldPrice,
              'price': productModel.price,
              'size': productModel.size,
              'stock': productModel.stock,
              'userId': productModel.userId,
              'quantity': productModel.quantity,
              'searchName': productModel.searchName
            });
      }).whenComplete(() async {
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('Something went wrong ', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

  //cartList

  static Future<bool> getCartProduct(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    QuerySnapshot homeSnapshot = await userDir
        .doc(pref.getString(userIdKey))
        .collection('cart')
        .get()
        .whenComplete(() {
      finished = true;
    }).catchError((e) {
      finished = false;
      showToast('You might be offline kindly check your internet connection',
          errorRed);
    });
    List<ProductModel> prodPost =
        homeSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    Provider.of<UiProvider>(context, listen: false).fromCart(prodPost);

    log('done with getting prod');
    return finished;
  }

//delete from cart

  static Future<bool> deleteCartItem(String id) async {
    late bool finished;
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await init.runTransaction((transaction) async {
        transaction.delete(
            userDir.doc(pref.getString(userIdKey)).collection('cart').doc(id));
      }).whenComplete(() async {
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('Something went wrong ', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

// check enabled

// enable orders
  static Future<bool> chechEnablePlatformOrders(String id) async {
    late bool finished;
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await FirebaseFirestore.instance
          .collection("controls")
          .doc(id)
          .get()
          .then((e) {
        finished = e.get('enable');
      }).whenComplete(() async {
        //  finished = true;
        // showToast('Done ', successBlue);
      }).catchError((e) async {
        // finished = false;
        showToast('Something went wrong ', errorRed);
      });
    } catch (e) {
      showToast('Something went wrong $e ', errorRed);
    }

    return finished;
  }

  static Future<bool> enablePlatformOrders(String id, bool val) async {
    late bool finished;
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await init.runTransaction((transaction) async {
        transaction
            .update(FirebaseFirestore.instance.collection('controls').doc(id), {
          'enable': val,
        });
      }).whenComplete(() async {
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('Something went wrong ', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

// process order
  static Future<bool> processOrder(
      List<AdminOrderModel> adminDeals, String id, bool val) async {
    late bool finished;

    try {
      await Future.forEach(adminDeals, (element) async {
        await init.runTransaction((transaction) async {
          transaction.update(
              FirebaseFirestore.instance
                  .collection('adminOrder')
                  .doc(id)
                  .collection("orders")
                  .doc(element.id),
              {
                'recieved': val,
              });

          transaction.update(
              userDir.doc(id).collection("orderHistory").doc(element.id), {
            'recieved': val,
          });
          transaction.delete(
            FirebaseFirestore.instance
                .collection('adminOrder')
                .doc(id)
                .collection("orders")
                .doc(element.id),
          );
        });
      }).whenComplete(() async {
        await init.runTransaction((transaction) async {
          transaction.delete(
            FirebaseFirestore.instance.collection('adminOrder').doc(id),
          );
        });
        finished = true;
      });
      showToast('done', successBlue);
    } catch (e) {
      finished = false;
      showToast('$e', errorRed);
    }

    return finished;
  }

//Search
  static Future<bool> searchProducts(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    QuerySnapshot searchSnapshot = await productDir
        .where('searchName',
            isGreaterThanOrEqualTo: pref.getString('search')!.toLowerCase())
        .limit(10)
        .get()
        .whenComplete(() {
      finished = true;
    }).catchError((e) {
      finished = false;
      showToast(e, errorRed);
    });
    List<ProductModel> prodPost =
        searchSnapshot.docs.map((doc) => ProductModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    Provider.of<UiProvider>(context, listen: false).addSearchProduct(prodPost);

    print('done with search prod');
    return finished;
  }

  //add shipping address info
  static Future<bool> postShippingInfo(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    try {
      await init.runTransaction((transaction) async {
        transaction.update(userDir.doc(pref.getString(userIdKey)), {
          'phoneNumber': pref.getString(phoneKey),
          'userLocation': pref.getString(addressKey),
        });
      }).whenComplete(() async {
        await Provider.of<UiProvider>(context, listen: false)
            .addAdress(pref.getString(addressKey)!);
        // ignore: use_build_context_synchronously
        await Provider.of<UiProvider>(context, listen: false)
            .addPhone(pref.getString(phoneKey)!);
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('$e', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

  //send feedback
  static Future<bool> sendFeedback(BuildContext context, String feed) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    try {
      await init.runTransaction((transaction) async {
        transaction.set(
            FirebaseFirestore.instance
                .collection("feedback")
                .doc(pref.getString(userIdKey)),
            {
              'name': pref.getString(nameKey),
              'feedback': feed,
            });
      }).whenComplete(() async {
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('$e', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

    //send feedback
  static Future<bool> sendFuelMeter(BuildContext context, FuelUpdate fuel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    try {
      await init.runTransaction((transaction) async {
        transaction.set(
            FirebaseFirestore.instance
                .collection("fuel")
                .doc("oneGod1997"),
            {
              'fare': fuel.fare,
              'litres': fuel.litres,
              'maxlitres':fuel.maxLitres,
              'minlitres': fuel.minLitres,
              'price': fuel.price
            });
      }).whenComplete(() async {
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('$e', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

//add userInfo
  static Future<bool> postUserInfo(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    try {
      await init.runTransaction((transaction) async {
        transaction.update(userDir.doc(pref.getString(userIdKey)), {
          'phoneNumber': pref.getString(phoneKey),
          'userLocation': pref.getString(addressKey),
          'email': pref.getString(emailKey),
          'name': pref.getString(nameKey),
        });
      }).whenComplete(() async {
        await Provider.of<UiProvider>(context, listen: false)
            .addAdress(pref.getString(addressKey)!);
        // ignore: use_build_context_synchronously
        await Provider.of<UiProvider>(context, listen: false)
            .addPhone(pref.getString(phoneKey)!);
        // ignore: use_build_context_synchronously
        await Provider.of<UiProvider>(context, listen: false)
            .addUserName(pref.getString(nameKey)!);
        // ignore: use_build_context_synchronously
        await Provider.of<UiProvider>(context, listen: false)
            .addMail(pref.getString(emailKey)!);
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('$e', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

// Make an order
  static Future<bool> makeOrder(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    late bool finished;
    try {
      // ignore: use_build_context_synchronously
      await Future.forEach(provider.cartList, (ProductModel element) async {
        // send copy to admin
        await init.runTransaction((transaction) async {
          transaction.set(
              adminOrdersDir
                  .doc(pref.getString(userIdKey))
                  .collection('orders')
                  .doc(element.id),
              {
                'name': element.name,
                'category': element.category,
                'color': element.color,
                'description': element.description,
                'images': element.images,
                'oldPrice': element.oldPrice,
                'price': element.price,
                'size': element.size,
                'stock': element.stock,
                'userId': pref.getString(userIdKey), // buyer id
                'quantity': element.quantity,
                'ShopId': element.userId, //shop uinique id
                'recieved': false,
                'email': provider.email,
                'phone': provider.phoneNumber,
                'address': provider.address,
                'buyerName': provider.name,
                'shopName': "",
                'shopPhoneNumber': "",
                'timestamp': Timestamp.now()
              });
        });

        //Send copy to seller
        await init.runTransaction((transaction) async {
          transaction.set(
              userDir
                  .doc(element.userId)
                  .collection('newOrders')
                  .doc(element.id),
              {
                'name': element.name,
                'category': element.category,
                'color': element.color,
                'description': element.description,
                'images': element.images,
                'oldPrice': element.oldPrice,
                'price': element.price,
                'size': element.size,
                'stock': element.stock,
                'userId': pref.getString(userIdKey),
                'quantity': element.quantity,
                'ShopId': element.userId,
                'recieved': false,
                'email': provider.email,
                'phone': provider.phoneNumber,
                'address': provider.address,
                'buyerName': provider.name,
                'shopName': "",
                'shopPhoneNumber': "",
                'timestamp': Timestamp.now()
              });
        });

        // send copy to user deals
        await init.runTransaction((transaction) async {
          transaction.set(
              userDir
                  .doc(pref.getString(userIdKey))
                  .collection('orderHistory')
                  .doc(element.id),
              {
                'name': element.name,
                'category': element.category,
                'color': element.color,
                'description': element.description,
                'images': element.images,
                'oldPrice': element.oldPrice,
                'price': element.price,
                'size': element.size,
                'stock': element.stock,
                'userId': pref.getString(userIdKey),
                'quantity': element.quantity,
                'ShopId': element.userId,
                'recieved': false,
                'email': provider.email,
                'phone': provider.phoneNumber,
                'address': provider.address,
                'buyerName': provider.name,
                'shopName': "",
                'shopPhoneNumber': "",
                'timestamp': Timestamp.now()
              });
        });

        //delete from cart
        await init.runTransaction((transaction) async {
          transaction.delete(userDir
              .doc(pref.getString(userIdKey))
              .collection('cart')
              .doc(element.id));
        });
      }).whenComplete(() async {
        List<String>? getNote = pref.getStringList(notificationKey);
        getNote!.add('You just placed an order findd will contact you soon ');
        await pref.setStringList(notificationKey, getNote);

        // ignore: use_build_context_synchronously
        await getCartProduct(context);
        // ignore: use_build_context_synchronously
        //  await getUserDeal(context);
        finished = true;
      }).catchError((e) {
        finished = false;
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

// get user deals
  static Future<bool> getUserDeal(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    print(pref.getString(userIdKey));
    QuerySnapshot homeSnapshot = await userDir
        .doc(pref.getString(userIdKey))
        .collection('orderHistory')
        .limit(10)
        .orderBy('timestamp', descending: true)
        .get()
        .whenComplete(() {
      finished = true;
    }).catchError((e) {
      finished = false;
      showToast('You might be offline kindly check your internet connection',
          errorRed);
    });
    List<OrderModel> prodPost =
        homeSnapshot.docs.map((doc) => OrderModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    Provider.of<UiProvider>(context, listen: false).addOneDeals(prodPost);

    log('done with getting deals');
    return finished;
  }

  static Future<bool> getUserFuelDeal(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    print(pref.getString(userIdKey));
    QuerySnapshot homeSnapshot = await userDir
        .doc(pref.getString(userIdKey))
        .collection('fuelHistory')
        .limit(10)
        .orderBy("timestamp", descending: true)
        .get()
        .whenComplete(() {
      finished = true;
    }).catchError((e) {
      finished = false;
      showToast('You might be offline kindly check your internet connection',
          errorRed);
    });
    List<FuelModel> fuelPost =
        homeSnapshot.docs.map((doc) => FuelModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    Provider.of<UiProvider>(context, listen: false).addFuelDeals(fuelPost);

    log('done with getting fuel deals');
    return finished;
  }

  static Future<bool> getAdminFuelDeal(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    print(pref.getString(userIdKey));
    QuerySnapshot homeSnapshot = await FirebaseFirestore.instance
        .collection('adminFuel')
        .orderBy("timestamp", descending: true)
        .get()
        .whenComplete(() {
      finished = true;
    }).catchError((e) {
      finished = false;
      showToast('You might be offline kindly check your internet connection',
          errorRed);
    });
    List<FuelModel> fuelPost =
        homeSnapshot.docs.map((doc) => FuelModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    Provider.of<UiProvider>(context, listen: false).addAdminFuelDeals(fuelPost);

    log('done with getting fuel deals');
    return finished;
  }

// get admin deals
  static Future<bool> getAdminOrderDeal(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UiProvider data = Provider.of<UiProvider>(context, listen: false);
    late bool finished;
    QuerySnapshot homeSnapshot = await adminOrdersDir.get().whenComplete(() {
      finished = true;
    }).catchError((e) {
      finished = false;
      showToast('You might be offline kindly check your internet connection',
          errorRed);
    });

    List<AdminOrderUserId> userId =
        homeSnapshot.docs.map((doc) => AdminOrderUserId.fromDoc(doc)).toList();

    // List<AdminOrderModel> prodPost =
    //     homeSnapshot.docs.map((doc) => AdminOrderModel.fromDoc(doc)).toList();

    // ignore: use_build_context_synchronously
    data.addAdminUserId(userId);

    List<UserModel> users = await getOrderedUsersFromIds(data.orderIds);

    data.addUsersOrdered(users);

    // print(users.first.email);

    log('done with getting deals');
    return finished;
  }

// get ordered users from ids
  static Future<List<UserModel>> getOrderedUsersFromIds(
      List<AdminOrderUserId> id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late bool finished;
    late List<UserModel> users = [];

    try {
      await Future.forEach(id, (element) async {
        DocumentSnapshot homeSnapshot = await userDir.doc(element.id).get();
        users.add(UserModel(
            id: homeSnapshot.get("id"),
            name: homeSnapshot.get("name"),
            profileImageUrl: homeSnapshot.get("profileImageUrl"),
            email: homeSnapshot.get("email")));
      });
    } catch (e) {
      print(e);
    }

    return users;
  }

// get admin user orders
  static Future<bool> getAdminUserOrderDeal(
      BuildContext context, String id) async {
    print(id);
    UiProvider data = Provider.of<UiProvider>(context, listen: false);
    late bool finished;
    try {
      QuerySnapshot homeSnapshot = await adminOrdersDir
          .doc(id.toString())
          .collection("orders")
          .orderBy('timestamp', descending: true)
          .get()
          .whenComplete(() {
        // print("just complete");
        finished = true;
      }).catchError((e) {
        finished = false;
        showToast('You might be offline kindly check your internet connection',
            errorRed);
      });

      List<AdminOrderModel> prodPost =
          homeSnapshot.docs.map((doc) => AdminOrderModel.fromDoc(doc)).toList();

      // ignore: use_build_context_synchronously
      data.addAdminUserDeals(prodPost);

      log('done with getting deals');
    } catch (e) {
      print(e);
      finished = false;
    }

    return finished;
  }

  //update dp
  static Future<bool> updateProfileImage(
      BuildContext context, String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(dpKey, url);
    late bool finished;
    try {
      await init.runTransaction((transaction) async {
        transaction.update(userDir.doc(pref.getString(userIdKey)), {
          'profileImageUrl': url,
        });
      }).whenComplete(() async {
        await Provider.of<UiProvider>(context, listen: false)
            .addDp(pref.getString(dpKey)!);
        finished = true;
      }).catchError((e) async {
        finished = false;
        showToast('$e', errorRed);
      });
    } catch (e) {
      finished = false;
    }

    return finished;
  }

  static Future<void> getDeliveryPrices(BuildContext context) async {
    late List<int> prices;
    UiProvider _price = Provider.of<UiProvider>(context, listen: false);

    FirebaseFirestore.instance
        .collection("controls")
        .doc("oneGod1997")
        .get()
        .then((value) {
      prices = [];
      prices.add(value.data()!["home"]);
      prices.add(value.data()!["pickup"]);
    }).whenComplete(() => _price.addDeliveryPrices(prices));
  }
}
