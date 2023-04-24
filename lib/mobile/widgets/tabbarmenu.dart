import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/caroussel.dart';
import 'package:shoppingyou/mobile/widgets/productList.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';


class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      height: MediaQuery.of(context).size.height * 10,
      child: const ProductList(),
      
    
    );
  }
}