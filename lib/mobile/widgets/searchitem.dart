import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/models/prod_model.dart';

import '../screens/product/singleitemscreen.dart';

class SearchItem extends StatelessWidget {
  final ProductModel model;
  const SearchItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.elliptical(20.0, 20.0)),
          splashColor: Colors.white,
          onTap: () {
            //  Navigator.pushNamed(context, '/singleitem');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingleItem(
                          product: model,
                        )));
          },
          child: SizedBox(
            width: 156,
            height: 252,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: const Alignment(-0.9, -2.0),
                  child: Image(
                      image: CachedNetworkImageProvider(
                    model.images!.last!,
                  )),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 31.0),
                    child: Text(
                      model.name!,
                      style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 98.0, bottom: 31.0),
                    child: Center(
                      child: Text(
                        "\$ ${model.price!}",
                        style: const TextStyle(
                            color: Color(0xff5956E9), fontSize: 17.0),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
