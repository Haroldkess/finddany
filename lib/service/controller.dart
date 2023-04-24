// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/database_service.dart';
import 'package:shoppingyou/service/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/order_model.dart';
import '../models/send_fuel_update.dart';
import 'state/ui_manager.dart';

class Controls {
  static Future<bool> validateForm(context) async {
    late bool isValidated;
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    await _provider.initializePref();

    String _email = _provider.getPref.getString(emailKey) == null
        ? ''
        : _provider.getPref.getString(emailKey)!;
    String _password = _provider.getPref.getString(passwordKey) == null
        ? ''
        : _provider.getPref.getString(passwordKey)!;

    if ((!_email.contains('@') || _email.length < 4 || _email.isEmpty) ||
        (_password.isEmpty || _password.length < 4 || _password.isEmpty)) {
      isValidated = false;
    } else {
      isValidated = true;
    }

    return isValidated;
  }

  static Future<bool> validateForm2(context) async {
    late bool isValidated;
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    await _provider.initializePref();

    String _email = _provider.getPref.getString(emailKey) == null
        ? ''
        : _provider.getPref.getString(emailKey)!;
    String _password = _provider.getPref.getString(passwordKey) == null
        ? ''
        : _provider.getPref.getString(passwordKey)!;

    String _name = _provider.getPref.getString(nameKey) == null
        ? ''
        : _provider.getPref.getString(nameKey)!;

    if ((!_email.contains('@') || _email.length < 4 || _email.isEmpty) ||
        (_password.isEmpty || _password.length < 4 || _password.isEmpty) ||
        (_name.isEmpty || _name.length < 2)) {
      isValidated = false;
    } else {
      isValidated = true;
    }

    return isValidated;
  }

  //Talks to the signUp Service
  static Future<bool> authUserSignUp(BuildContext context) async {
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    _provider.load(true);
    bool signUpUser = await AuthService.signUpUser(context);

    if (signUpUser) {
      _provider.load(false);
    } else {
      showToast2(context, 'something went wrong please try again',
          isError: true);
      _provider.load(false);
    }
    _provider.load(false);
    return signUpUser;
  }

  static Future<bool> authUserLogin(BuildContext context) async {
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    _provider.load(true);

    bool signUpUser =
        await AuthService.login(context).timeout(const Duration(seconds: 30));

    if (signUpUser) {
      _provider.load(false);
    } else {
      showToast2(context, 'something went wrong please try again',
          isError: true);
      _provider.load(false);
    }

    _provider.load(false);

    return signUpUser;
  }

  static Future<bool> verifyProdForm(BuildContext context, String desc,
      String name, String price, String oldPrice, int stock) async {
    late bool validated;
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);

    if (desc.isEmpty ||
        name.isEmpty ||
        price.isEmpty ||
        stock < 1 ||
        oldPrice.isEmpty ||
        provider.images.isEmpty ||
        provider.selectedCategory == "Select Category") {
      validated = false;
    } else {
      validated = true;
    }
    return validated;
  }

  static Future<bool> uploadProductInfo(
      BuildContext context,
      String desc,
      List<String> color,
      String name,
      String price,
      String oldPrice,
      List<String> size,
      int stock) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    await provider.initializePref();
    provider.load(true);
    List<String> url = [];

    await Future.forEach(provider.images, (Uint8List element) async {
      String getUrl = await DatabaseService.uploadPost(element);

      url.add(getUrl);
    });

    ProductModel model = ProductModel(
        category: provider.selectedCategory,
        color: color,
        description: desc,
        images: url,
        name: name,
        oldPrice: oldPrice,
        price: price,
        size: size,
        stock: stock,
        userId: provider.pref!.getString(userIdKey),
        searchName: name.toLowerCase());

    bool postTracker = await DatabaseService.postProducts(model);

    if (postTracker) {
      provider.changeCategory('Select Category');
      provider.clearPickedProductPictures();
      provider.load(false);

      // ignore: use_build_context_synchronously
      showToast2(context, 'Product posted successfully!', isError: false);
    } else {
      showToast2(context, 'something went wrong please try again',
          isError: true);
      provider.load(false);
    }
    provider.load(false);

    return postTracker;
  }

//add to cart controller
  static Future<bool> uploadToCart(
      BuildContext context,
      String id,
      String desc,
      List<String> color,
      String name,
      String price,
      String oldPrice,
      List<String> size,
      List images,
      int stock,
      int qty,
      String shopOwnerId) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    await provider.initializePref();
    provider.load(true);

    ProductModel model = ProductModel(
        id: id,
        category: provider.selectedCategory,
        color: color,
        description: desc,
        images: images,
        name: name,
        oldPrice: oldPrice,
        price: price,
        size: size,
        stock: stock,
        quantity: qty,
        userId: shopOwnerId,
        searchName: name.toLowerCase());

    bool postTracker = await DatabaseService.addToCart(model);

    if (postTracker) {
      provider.load(false);
      showToast2(context, 'Product Added To Cart Successfully!',
          isError: false);

      // ignore: use_build_context_synchronously
      await cartCollectionControl(context);
    } else {
      provider.load(false);
    }
    provider.load(false);
    return postTracker;
  }

//get shop you category
  static Future<void> getCategory(BuildContext context) async {
    UiProvider _provider = Provider.of<UiProvider>(context, listen: false);
    categoryDir.doc('oneGod1997').get().then((value) {
      final getCategory = value.data()!['categories'];
      log(getCategory.toString());
      _provider.addCategory(getCategory);
    }).catchError((e) {
      showToast2(
          context, 'You might be offline kindly check your internet connection',
          isError: true);
    });
  }

  //get products
  static Future<void> getHomeProduct(
      BuildContext context, bool isCategory) async {
    bool done = await DatabaseService.getHomeProduct(context, isCategory);
    if (done) {
    } else {}
  }

  // get quickpicks
  static Future<void> getQuickPicksProduct(BuildContext context) async {
    bool done = await DatabaseService.getQuickPickProduct(context);
    if (done) {
    } else {}
  }
  //get slider

  static Future<void> getSliderProduct(BuildContext context) async {
    bool done = await DatabaseService.getSliderProduct(context);
    if (done) {
    } else {}
  }

  // get popular
  static Future<void> getPopularProduct(BuildContext context) async {
    bool done = await DatabaseService.getPopularProduct(context);
    if (done) {
    } else {}
  }

  //get justFor you
  static Future<void> getJustForYouProduct(BuildContext context) async {
    bool done = await DatabaseService.getJustForYouProduct(context);
    if (done) {
    } else {}
  }

  //get cart list
  static Future<void> cartCollectionControl(BuildContext context) async {
    bool done = await DatabaseService.getCartProduct(context);
    if (done) {
    } else {}
  }

  //get search list
  static Future<void> searchController(BuildContext context) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    provider.load(true);

    // ignore: use_build_context_synchronously
    bool done = await DatabaseService.searchProducts(context);
    if (done) {
      provider.load(false);

      //  showToast2(context, 'Search Completed!',);
    } else {
      provider.load(false);

      showToast2(context, 'Something went wrong!', isError: true);
    }
    provider.load(false);
  }

//get done deals
  //get cart list
  static Future<void> doneDealsController(BuildContext context) async {
    bool done = await DatabaseService.getUserDeal(context);
    if (done) {
    } else {}
  }

  // get fuel history
  static Future<void> fuelHistoryController(BuildContext context) async {
    bool done = await DatabaseService.getUserFuelDeal(context);
    if (done) {
    } else {}
  }

  // get admin fuel orders
  static Future<void> adminFuelHistoryController(BuildContext context) async {
    bool done = await DatabaseService.getAdminFuelDeal(context);
    if (done) {
    } else {}
  }

  // get admin  order by user
  static Future<void> doneAdminOrderController(BuildContext context) async {
    bool done = await DatabaseService.getAdminOrderDeal(context);
    if (done) {
    } else {}
  }

  // get admin user order
  static Future<void> doneAdminUserOrderController(
      BuildContext context, String id) async {
    bool done = await DatabaseService.getAdminUserOrderDeal(context, id);
    if (done) {
    } else {}
  }

  // shipping info
  //get search list
  static Future<void> shippingInfoController(BuildContext context) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    provider.load(true);

    // ignore: use_build_context_synchronously
    bool done = await DatabaseService.postShippingInfo(context);
    if (done) {
      provider.load(false);

      showToast2(
        context,
        'Shipping Information Updated Successfully!',
      );
    } else {
      provider.load(false);

      showToast2(context, 'Something went wrong!', isError: true);
    }
    provider.load(false);
  }

  //send feedback
  static Future<void> sendFeedBackController(
      BuildContext context, String feed) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    provider.load(true);

    // ignore: use_build_context_synchronously
    bool done = await DatabaseService.sendFeedback(context, feed);
    if (done) {
      provider.load(false);

      showToast2(context, 'Feedback sent Successfully!', isError: false);
    } else {
      provider.load(false);

      showToast2(context, 'Something went wrong!', isError: true);
    }
    provider.load(false);
  }

// update fuel price
  static Future<void> updateFuelController(
      BuildContext context, FuelUpdate fuel) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    provider.load(true);

    // ignore: use_build_context_synchronously
    bool done = await DatabaseService.sendFuelMeter(context, fuel);
    if (done) {
      provider.load(false);

      showToast2(context, 'Fuel Meter  updated Successfully!', isError: false);
    } else {
      provider.load(false);

      showToast2(context, 'Something went wrong!', isError: true);
    }
    provider.load(false);
  }

// edit user info
  static Future<void> editUserController(BuildContext context) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    provider.load(true);

    // ignore: use_build_context_synchronously
    bool done = await DatabaseService.postUserInfo(context);
    if (done) {
      provider.load(false);

      showToast2(context, 'Your Profile has been Updated Successfully!',
          isError: false);
    } else {
      provider.load(false);
      showToast2(context, 'Something went wrong!', isError: true);
    }
    provider.load(false);
  }

  //delete from cart
  static Future<bool> deleteCartItem(
    BuildContext context,
    String id,
  ) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    await provider.initializePref();
    provider.load(true);

    bool deleteTracker = await DatabaseService.deleteCartItem(id);

    if (deleteTracker) {
      provider.load(false);
      showToast2(context, 'Item deleted successfully !', isError: false);
    } else {
      provider.load(false);
      showToast2(context, 'Something went wrong', isError: true);
    }
    provider.load(false);

    return deleteTracker;
  }

// process
  static Future<bool> process(BuildContext context,
      List<AdminOrderModel> adminDeals, String id, bool val) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);

    provider.load(true);

    // ignore: use_build_context_synchronously
    bool enableTracker =
        await DatabaseService.processOrder(adminDeals, id, val);

    if (enableTracker) {
      provider.load(false);

      showToast2(context, ' successfull!', isError: false);
    } else {
      provider.load(false);

      showToast2(context, 'Something went wrong', isError: true);
    }
    provider.load(false);

    return enableTracker;
  }

  static Future<bool> checkEnable(
    BuildContext context,
    String id,
  ) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    await provider.initializePref();
    // provider.load(true);

    bool enableTracker = await DatabaseService.chechEnablePlatformOrders(id);

    if (enableTracker) {
      //provider.load(false);
      //  showToast(' successfull!', successBlue);
    }

    return enableTracker;
  }

  static Future<bool> enable(BuildContext context, String id, bool val) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    await provider.initializePref();
    provider.load(true);

    bool enableTracker = await DatabaseService.enablePlatformOrders(id, val);

    if (enableTracker) {
      provider.load(false);

      showToast2(context, ' successfull!', isError: false);
    } else {
      provider.load(false);
      showToast2(context, 'Something went wrong', isError: true);
    }
    provider.load(false);
    return enableTracker;
  }
}

class Utility {
  static Future<void> pickProductImages(BuildContext context) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    List<Uint8List> file = [];
    FilePickerResult? mediaInfo = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (mediaInfo == null) return;
    mediaInfo.files.forEach((element) async {
      if (file.length < 3) {
        file.add(element.bytes!);
      } else {
        return;
      }
    });
    provider.addPickedProductPictures(file);
  }

  static Future<void> pickProfileImage(BuildContext context) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);
    Uint8List file;
    FilePickerResult? mediaInfo = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (mediaInfo == null) return;
    file = mediaInfo.files.single.bytes!;
    provider.addProfilePicture(file);
    provider.load(true);
    String getUrl = await DatabaseService.uploadPost(file);
    if (getUrl != null || getUrl.isNotEmpty) {
      // ignore: use_build_context_synchronously
      print(getUrl);
      bool isDone = await DatabaseService.updateProfileImage(context, getUrl);
      if (isDone) {
        showToast2(context, 'You changed your profile image successfully ');
        provider.load(false);
      } else {
        showToast2(context,
            'We could not update your profile image at the moment please try again later.',
            isError: true);
        provider.load(false);
      }
      provider.load(false);
    }
    provider.load(false);
  }

  static Future<void> makePayment(BuildContext context, int addedAmount) async {
    UiProvider provider = Provider.of<UiProvider>(context, listen: false);

    await provider.initializePref();
    provider.load(true);
    int added = 100;
    int resolvedPrice = (provider.totalPrice + addedAmount) * added;

    try {
      final charge = Charge()
        ..email = provider.pref!.getString(emailKey)
        ..amount = resolvedPrice
        ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';
      // ignore: use_build_context_synchronously
      final res = await PaystackClient.checkout(context, charge: charge);

      if (res.status) {
        // ignore: use_build_context_synchronously
        bool sendOrder = await DatabaseService.makeOrder(context);
        if (sendOrder) {
          provider.load(false);
          Navigator.pop(context);
          // showToast(
          //     'Charge was successful. Ref: ${res.reference}', successBlue);

          showToast2(context, 'Order Completed succseffully ', isError: false);
        } else {
          showToast2(context, 'waiting for network do not Exit page  ',
              isError: false);

          bool sendOrder = await DatabaseService.makeOrder(context);
          if (sendOrder) {
            provider.load(false);

            Navigator.pop(context);
            // showToast(
            //     'Charge was successful. Ref: ${res.reference}', successBlue);
            showToast2(context, 'Order Completed succseffully ',
                isError: false);
          }
        }
      } else {
        provider.load(false);
        Navigator.pop(context);
        showToast2(context, 'Failed: ${res.message}', isError: true);
      }
    } catch (error) {
      provider.load(false);
      Navigator.pop(context);
      print('Payment Error ==> $error');
    }
    provider.load(false);
    Navigator.pop(context);
    // provider.load(false);
  }

    static Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
