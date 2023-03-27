import 'package:flutter/cupertino.dart';

class FuelManager extends ChangeNotifier {
  double _sellingPrice = 0.0;
  int _maxLitres = 0;
  int _minLitres = 0;
  int _availablelitres = 0;
  int _fare = 0;
  bool _loadStatus = false;

  double selectedLires = 5.0;
  String liveIn = "";

  double get sellingPrice => _sellingPrice;
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
      double price, int max, int min, int available, int transport) async {
    _sellingPrice = price;
    _maxLitres = max;
    _minLitres = min;
    _availablelitres = available;
    _fare = transport;
    notifyListeners();
  }
}
