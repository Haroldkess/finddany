import 'package:flutter/cupertino.dart';

class FuelManager extends ChangeNotifier {
  var _sellingPrice = 0;
  var _maxLitres = 0;
  var _minLitres = 0;
  var _availablelitres = 0;
  var _fare = 0;
  bool _loadStatus = false;

  double selectedLires = 1.0;
  String liveIn = "";

  int get sellingPrice => _sellingPrice;
  int get maxLitres => _maxLitres;
  int get minLitres => _minLitres;
  int get availableLitres => _availablelitres;
  bool get loadStatus => _loadStatus;
  int get fare => _fare;

  void addLiveIn(String live) {
    liveIn = live;
    notifyListeners();
  }

  Future<void> addSelectedLitres(double val) async {
    selectedLires = val;
    notifyListeners();
  }

  Future<void> isLoading(bool isLoad) async {
    _loadStatus = isLoad;
    notifyListeners();
  }

  Future<void> addLitreValues(
      var price, int max, int min, int available, int transport) async {
    _sellingPrice = price;
    _maxLitres = max;
    _minLitres = min;
    _availablelitres = available;
    _fare = transport;
    notifyListeners();
  }
}
