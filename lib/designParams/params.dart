import 'package:universal_io/io.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

double maxFactor = 1.5;
String appName = 'Finddany';
double minFactor = 0.7;

Color defaultColor = Color(0xFF0D471);

double iconSizes = 15.0;

const double symmetricPadding = 5.0;
NumberFormat numberFormat = NumberFormat.decimalPattern();

double onlyAllPadding = 8.0;
  currencySymbol() {
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
  }