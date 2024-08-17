import 'dart:developer';

import 'package:intl/intl.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class Operations {
  static String convertDate(DateTime date) {
    late String newDate;
    if (date.month == 1) {
      newDate = "Jan";
    } else if (date.month == 2) {
      newDate = "Feb";
    } else if (date.month == 3) {
      newDate = "Mar";
    } else if (date.month == 4) {
      newDate = "Apr";
    } else if (date.month == 5) {
      newDate = "May";
    } else if (date.month == 6) {
      newDate = "Jun";
    } else if (date.month == 7) {
      newDate = "Jul";
    } else if (date.month == 8) {
      newDate = "Aug";
    } else if (date.month == 9) {
      newDate = "Sep";
    } else if (date.month == 10) {
      newDate = "Oct";
    } else if (date.month == 11) {
      newDate = "Nov";
    } else if (date.month == 12) {
      newDate = "Dec";
    }

    return "$newDate ${date.day}, ${date.year} - ${date.hour}:${date.minute}";
  }

  static convertToCurrency(e) {
    String newStr = e.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[0]},");
    return newStr;
  }

  static debug(val) {
    print(val.toString());
  }

  static track(lat, long) async {
    String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    String appleMapsUrl = "https://maps.apple.com/?q=$lat,$long";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not launch URL';
    }
  }
}
