import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/designParams/params.dart';
import '../../responsive/responsive_config.dart';

class HowToBeAVendor extends StatefulWidget {
  const HowToBeAVendor({
    Key? key,
  }) : super(key: key);

  @override
  _HowToBeAVendorState createState() => _HowToBeAVendorState();
}

class _HowToBeAVendorState extends State<HowToBeAVendor> {
  @override
  void initState() {
    super.initState();
    // getProd();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      animate: true,
      duration: Duration(seconds: 5),
      child: InkWell(
               onTap: () async {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => StayHome()));
                  },
        child: Container(
          height: 50,
          //width: 50,
          decoration: BoxDecoration(
              color: Color(0xff5956E9).withOpacity(0.8),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: onlyAllPadding),
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 10,
                //   backgroundImage: CachedNetworkImageProvider(
                //       widget.prod.productUnit!.photo == null
                //           ? noImage
                //           : widget.prod.productUnit!.photo!),
                // ),
                const Icon(
                  Icons.storefront_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 5.0,),
                Text(
                  'Vendor ?',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                       color:  Colors.white,
                      fontSize: Responsive.isMobile(context) ? 20 : 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
