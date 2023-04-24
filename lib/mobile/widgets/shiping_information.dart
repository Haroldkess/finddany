import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class ShippingInfo extends StatelessWidget {
  const ShippingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: 15,
    );
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: Responsive.isMobile(context) ? 5 : 24,
            right: Responsive.isMobile(context) ? 5 : 24,
            top: 15,
            bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          ShippingInfoItem(
            iconData: Icons.person_outline,
            text: context.watch<UiProvider>().name,
          ),
          ShippingInfoItem(
              iconData: Icons.location_on_outlined,
              text: context.watch<UiProvider>().address == 'null'
                  ? '...'
                  : context.watch<UiProvider>().address),
          ShippingInfoItem(
            iconData: Icons.phone_outlined,
            text: context.watch<UiProvider>().phoneNumber == 'null'
                ? 'WhatsApp Number'
                : context.watch<UiProvider>().phoneNumber,
          ),
        ]),
      ),
    );
  }
}

class ShippingInfoItem extends StatelessWidget {
  final TextStyle textStyle = TextStyle(fontSize: 15);
  final String text;
  final IconData? iconData;
  ShippingInfoItem({Key? key, this.text = '', this.iconData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            iconData,
            size: 28,
            color: Color(0XFF200E32),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
