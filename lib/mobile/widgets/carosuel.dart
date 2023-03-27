import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerSlider extends StatefulWidget {
  BannerSlider({Key? key}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          width: 0.5,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Stack(
        children: [
          Carousel(
            boxFit: BoxFit.fill,
            images: const [
              NetworkImage(
                  'https://www.qpr.co.uk/media/26690/2400x1350-flashsale-generic.jpg?anchor=center&mode=crop&width=900&height=506&quality=75'),

              NetworkImage(
                  'https://images.unsplash.com/photo-1515955656352-a1fa3ffcd111?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Ymx1ZSUyMHNob2VzfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
              NetworkImage(
                  'https://s.yimg.com/ny/api/res/1.2/4zk1IbvqsIXoCFqGgW91Eg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MA--/https://s.yimg.com/os/creatr-uploaded-images/2021-12/185b0830-5462-11ec-99fb-4fb8915f4348'),
              //AssetImage('assets/Frame 3072.png'),
              //  AssetImage('assets/Frame 30722.png'),
              //  AssetImage('assets/Rectangle 227.png'),
            ],
            showIndicator: true,
            borderRadius: true,
            noRadiusForIndicator: false,
            radius: Radius.circular(5.0),
            overlayShadow: false,
            overlayShadowColors: Colors.transparent,
            dotIncreaseSize: 1.3,
            dotBgColor: Colors.transparent,
            dotIncreasedColor: Colors.blue[900],
            autoplayDuration: Duration(seconds: 5),
          ),
      
        ],
      ),
    );
  }
}
