import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/caroussel.dart';
import 'package:shoppingyou/mobile/widgets/productList.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      height: MediaQuery.of(context).size.height * 10,
      child: const ProductList(),
      
      
      
      //  ContainedTabBarView(
      //   tabBarViewProperties:
      //       TabBarViewProperties(physics: AlwaysScrollableScrollPhysics()),
      //   tabBarProperties:  TabBarProperties(
      //       isScrollable: false,
      //       unselectedLabelColor: Color(0xff9a9a9d),
      //       labelColor: Color(0xff5956E9),
      //       labelPadding: EdgeInsets.zero,
      //       margin: EdgeInsets.only(bottom: 10),
      //       padding: EdgeInsets.only(left: Responsive.isDesktop(context) ?  20 : 5, bottom: 10, top: 5,right: Responsive.isDesktop(context) ?  20 : 5),
      //       indicatorColor: Color(0xff5956E9)),
      //   tabs: const [
      //     Text(
      //       'Wearable',
      //       style: TextStyle(
      //           fontFamily: 'Raleway',
      //           fontSize: 17.0,
      //           fontWeight: FontWeight.w600),
      //     ),
      //     Text(
      //       'Laptops',
      //       style: TextStyle(
      //           fontFamily: 'Raleway',
      //           fontSize: 17.0,
      //           fontWeight: FontWeight.w600),
      //     ),
      //     Text(
      //       'Phones',
      //       style: TextStyle(
      //           fontFamily: 'Raleway',
      //           fontSize: 17.0,
      //           fontWeight: FontWeight.w600),
      //     ),
      //     Text(
      //       'Drones',
      //       style: TextStyle(
      //           fontFamily: 'Raleway',
      //           fontSize: 17.0,
      //           fontWeight: FontWeight.w600),
      //     ),
      //   ],
      //   views: [
      //     ProductList(),
      //     ProductList(),
      //     ProductList(),
      //     ProductList(),
      //   ],
      //   onChange: (index) => print(index),
      // ),
   
   
    );
  }
}
