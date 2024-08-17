import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    UiProvider _provider = Provider.of<UiProvider>(context);

    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.location_pin,
                  size: 24.0,
                  color: Colors.grey,
                  semanticLabel: 'Address icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Address',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
            onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString(addressKey, value);
            },
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class ShippingCordinates extends StatefulWidget {
  const ShippingCordinates({Key? key}) : super(key: key);

  @override
  State<ShippingCordinates> createState() => _ShippingCordinatesState();
}

class _ShippingCordinatesState extends State<ShippingCordinates> {
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UiProvider provider = Provider.of<UiProvider>(context, listen: false);
      setState(() {
        controller = TextEditingController(text: provider.cordinates);
      });
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request the user to enable it.
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return an error.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, return an error.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    UiProvider _provider = Provider.of<UiProvider>(context);

    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Icon(Icons.pin_drop,
                  size: 24.0,
                  color: Colors.grey,
                  semanticLabel: 'address icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Set your exact location. \nPlease stand in your apartment before clicking',
                  style: TextStyle(color: Colors.green, fontSize: 16.0),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              Position position = await _getCurrentLocation();
              // print(
              //     'Latitude: ${position.latitude}, Longitude: ${position.longitude}');

              setState(() {
                controller = TextEditingController(
                    text:
                        'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
              });

              await _provider.initializePref();
              _provider.pref!.setString(cordinatesKey,
                  "${position.latitude}:::${position.longitude}");
            },
            child: TextField(
              controller: controller,
              onChanged: (value) async {
                await _provider.initializePref();
                _provider.pref!.setString(cordinatesKey, value);
              },
              enabled: false,
              decoration: const InputDecoration(
                hintText: ' Latitude  and Longitude',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
