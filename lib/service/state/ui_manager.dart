import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/models/user_model.dart';
import 'package:shoppingyou/service/constant.dart';

import '../../mobile/fuel/model/fuel_model.dart';
import '../../models/order_model.dart';

class UiProvider extends ChangeNotifier {
  bool showPassword = false;
  SharedPreferences? pref;
  SharedPreferences get getPref => pref!;
  List<ProductModel> prod = [];
  List<ProductModel> quickPicks = [];
  List<ProductModel> popular = [];
  List<ProductModel> sliderProd = [];
  List<ProductModel> justForYou = [];
  List<OrderModel> doneDeals = [];
  List<AdminOrderModel> adminDeals = [];
  List<OrderModel> myOrders = [];
  List<FuelModel> fuelOrders = [];
  List<FuelModel> adminFuelOrders = [];

  List<ProductModel> searchProd = [];
  String homeSelectedCategory = '';

  List<ProductModel> cartList = [];
  List<AdminOrderUserId> orderIds = [];
  List<UserModel> adminOrderUsers = [];
  String name = '';
  String email = '';
  String address = '';
  String phoneNumber = '';
  int totalPrice = 0;
  bool hasShop = false;

  List<Uint8List> images = [];
  Uint8List? profileDp;
  List shopYouCategory = [];
  String selectedCategory = 'Select Category';
  String imageUrl = '';
  String locationType = "";
  List<int> deliveryPrices = [0, 0];

  bool loading = false;
  bool get isLoading => loading;

  void addDeliveryPrices(List<int> dPrices) {
    deliveryPrices = dPrices;
    notifyListeners();
  }

  void addLocationType(String type) {
    locationType = type;
    notifyListeners();
  }

  void showPass(bool val) {
    showPassword = val;
    notifyListeners();
  }

  void addHomeSelected(String add) {
    homeSelectedCategory = add;
    notifyListeners();
  }

  void fromCart(List<ProductModel> model) async {
    cartList = model;
    totalPrice = 0;
    cartList.forEach(
      (element) => {
        totalPrice +=
            (int.tryParse(element.price!)! * element.quantity!.toInt())
      },
    );
    notifyListeners();
  }

  Future<void> addDp(String myDp) async {
    imageUrl = myDp;
    notifyListeners();
  }

  Future<void> addMail(String mymail) async {
    email = mymail;
    notifyListeners();
  }

  Future<void> addUserName(String myName) async {
    name = myName;
    notifyListeners();
  }

  Future<void> addAdress(String addres) async {
    address = addres;
    notifyListeners();
  }

  Future<void> addPhone(String phone) async {
    print(phone);
    phoneNumber = phone;
    notifyListeners();
  }

  Future<void> addHasShop(bool isOwner) async {
    print(isOwner.toString());
    hasShop = isOwner;
    notifyListeners();
  }

  void addOneDeals(List<OrderModel> order) {
    doneDeals = order;
    notifyListeners();
  }
   void addFuelDeals(List<FuelModel> fuels) {
    fuelOrders = fuels;
    notifyListeners();
  }

    void addAdminFuelDeals(List<FuelModel> fuelsOrder) {
    adminFuelOrders = fuelsOrder;
    notifyListeners();
  }

  void addAdminUserDeals(List<AdminOrderModel> adminOrders) {
    adminDeals = adminOrders;
    notifyListeners();
  }

  void addAdminUserId(List<AdminOrderUserId> adminOrdersIds) {
    orderIds = adminOrdersIds;
    notifyListeners();
  }

  void addUsersOrdered(List<UserModel> usersOrdered) {
    adminOrderUsers = usersOrdered;
    notifyListeners();
  }

  void addHomeProduct(List<ProductModel> model) {
    prod = model;
    notifyListeners();
  }

  void addSearchProduct(List<ProductModel> model1) {
    searchProd = model1;
    notifyListeners();
  }

  void addQiuckPicks(List<ProductModel> model2) {
    quickPicks = model2;
    notifyListeners();
  }

  void addPopular(List<ProductModel> model3) {
    popular = model3;
    notifyListeners();
  }

  void addSliderProd(List<ProductModel> model4) {
    sliderProd = model4;
    notifyListeners();
  }

  void addJustForYou(List<ProductModel> model5) {
    justForYou = model5;
    notifyListeners();
  }

  void changeCategory(String cat) {
    selectedCategory = cat;
    notifyListeners();
  }

  void addCategory(List cat) {
    shopYouCategory = cat;
    notifyListeners();
  }

  void addPickedProductPictures(List<Uint8List> _picked) {
    images = _picked;
    notifyListeners();
  }

  void addProfilePicture(Uint8List pic) {
    profileDp = pic;
    notifyListeners();
  }

  void clearPickedProductPictures() {
    images.clear();
    notifyListeners();
  }

  void removePickedProductPictures(int _picked) {
    images.removeAt(_picked);
    notifyListeners();
  }

  Future<void> initializePref() async {
    pref = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<bool> load(bool isload) async {
    if (isload) {
      loading = true;
      notifyListeners();
      return true;
    } else {
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
