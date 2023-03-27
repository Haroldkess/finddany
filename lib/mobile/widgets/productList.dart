import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/popping.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';

import '../../models/fake_user.dart';
import '../../models/prod_model.dart';
import '../../state/ui_manager.dart';
import 'carditem.dart';
import 'caroussel.dart';
import 'category_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children:  [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Quick picks for you',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: const Color(0xff5956E9),
                    fontSize: Responsive.isMobile(context) ? 20 :  30.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Stories(
          currentUser: onlineUsers.first,
          stories: stories,
          height: height,
        ),
        SizedBox(
          height: 30.0,
        ),
        const Caroussel(),
        //  BannerSlider(),
        SizedBox(
          height: 30.0,
        ),

        Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Color(0xff5956E9),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),

        const SizedBox(
          height: 20.0,
        ),
        Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? SizedBox(
                height: Responsive.isDesktop(context)
                    ? 400
                    : MediaQuery.of(context).size.height * 0.7,
                child: GridView.builder(
                  itemCount: Responsive.isDesktop(context)
                      ?  context.watch<UiProvider>().popular.length
                      : Responsive.isTablet(context)
                          ? context.watch<UiProvider>().popular.length
                          : context.watch<UiProvider>().popular.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                     final ProductModel prod =
                          Provider.of<UiProvider>(context, listen: false)
                              .popular[index];
                    return ProductItem(product: prod,);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isDesktop(context)
                        ? 4
                        : Responsive.isTablet(context)
                            ? 2
                            : 2,
                  ),
                ),
              )
            : const SizedBox.shrink(),

        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'We Specially Picked',
                    textStyle:  TextStyle(
                      fontSize: Responsive.isMobile(context) ? 20 : 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                      color: Colors.red,
                    ),
                    speed: const Duration(milliseconds: 20),
                  ),
                  TypewriterAnimatedText(
                    'Trending Brands!',
                    textStyle:  TextStyle(
                      fontSize: Responsive.isMobile(context) ? 20 : 32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                      color: Colors.red,
                    ),
                    speed: const Duration(milliseconds: 20),
                  ),
                  TypewriterAnimatedText(
                    'Just For You!',
                    textStyle:  TextStyle(
                      fontSize:Responsive.isMobile(context) ? 20 :  32.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Raleway',
                      color: Colors.red,
                    ),
                    speed: const Duration(milliseconds: 20),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                repeatForever: true,
                stopPauseOnTap: true,
              ),

              //  Text(
              //   'Order online collect in store',
              //   style: TextStyle(
              //       fontFamily: 'Raleway',
              //       fontSize: 34.0,
              //       fontWeight: FontWeight.w700),
              // ),
            ),
          ],
        ),

        const SizedBox(
          height: 10.0,
        ),
        const PoppingProduct(),
        const SizedBox(
          height: 20.0,
        ),

        Row(
          children:  [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'More from Us',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Color(0xff5956E9),
                    fontSize: Responsive.isMobile(context) ? 20 : 30.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),

        SizedBox(
          height: height * 7,
          child: GridView.builder(
            itemCount: context.watch<UiProvider>().prod.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
               final ProductModel prod =
                          Provider.of<UiProvider>(context, listen: false)
                              .prod[index];
              return  ProductItem(
                product: prod,
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context)
                    ? 4
                    : Responsive.isTablet(context)
                        ? 3
                        : 2,
                mainAxisExtent: 300,mainAxisSpacing: 1.0),
          ),
        ),
      ],
    );
  }
}
