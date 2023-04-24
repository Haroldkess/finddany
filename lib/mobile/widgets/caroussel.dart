import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/carditem.dart';

import '../../service/state/ui_manager.dart';

class Caroussel extends StatelessWidget {
  const Caroussel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();

    return Stack(
      alignment: Alignment.center,
      children: [
        // Padding(
        //     padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        //     child: ShaderMask(
        //         shaderCallback: (rect) {
        //           return const LinearGradient(
        //             begin: Alignment.center,
        //             end: FractionalOffset.bottomCenter,
        //             colors: [Colors.black, Colors.transparent],
        //           ).createShader(rect);
        //         },
        //         blendMode: BlendMode.dstIn,
        //         child: const Image(
        //             image: AssetImage('assets/images/splash.png'),
        //             fit: BoxFit.contain))),
        Column(
          children: <Widget>[
            CarouselSlider(
              carouselController: buttonCarouselController,
              items: context.watch<UiProvider>().sliderProd.map((e) => ProductItem( product: e,)).toList() ,
              options: CarouselOptions(
                height: 308,
                viewportFraction: 10.0,
                autoPlay: true,
                enlargeCenterPage: false,
                initialPage: 2,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => buttonCarouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear),
                child: const Text(
                  'Next ->',
                  style: TextStyle(
                      color: Color(0xff5956E9),
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
