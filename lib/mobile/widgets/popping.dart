import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';

import '../../service/state/ui_manager.dart';
import '../screens/product/singleitemscreen.dart';

class PoppingProduct extends StatefulWidget {
  const PoppingProduct({Key? key}) : super(key: key);

  @override
  State<PoppingProduct> createState() => _PoppingProductState();
}

class _PoppingProductState extends State<PoppingProduct> {
  List<String> popProd = [
    'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  context.watch<UiProvider>().justForYou
          .map((e) => AvatarGlow(
                endRadius: Responsive.isDesktop(context) ?  100 : Responsive.isTablet(context) ? 100 : 50,
                showTwoGlows: true,
                glowColor: Colors.red,
                child: InkWell(
                  onTap: (){
                     Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  SingleItem(product: e,)));
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(e.images!.first!.toString()),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
