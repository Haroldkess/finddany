import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/screens/product/singleitemscreen.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/service/constant.dart';

import '../../designParams/params.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.elliptical(20.0, 20.0)),
          splashColor: const Color(0xff5956E9).withOpacity(0.5),
          hoverColor: Color(0xff5956E9).withOpacity(0.5),
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const SingleItem()));
          },
          child: SizedBox(
            width: 220,
            height: 270,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  alignment: const Alignment(-0.9, -3.5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image(
                        image: CachedNetworkImageProvider(
                            'https://static01.nyt.com/images/2020/10/20/business/20TECHFIX01/20TECHFIX01-mediumSquareAt3X-v2.jpg')),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Apple Watch',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'),
                        ),
                        const Text(
                          'Series 6 Red',
                          style: TextStyle(
                              color: Color(0xff868686), fontSize: 16.0),
                        ),
                        const Text(
                          "\$ 359",
                          style: TextStyle(
                              color: Color(0xff5956E9), fontSize: 17.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 15,
                              ),
                              Icon(
                                Icons.star_border_outlined,
                                color: Colors.orange,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: const [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Available ',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final ProductModel? product;
  const ProductItem( {Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 //   ${currencySymbol()}${numberFormat.format(widget.shopProd!.sellPrice)}
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.elliptical(20.0, 20.0)),
          splashColor: const Color(0xff5956E9).withOpacity(0.5),
          hoverColor: Color(0xff5956E9).withOpacity(0.5),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  SingleItem(product: product,)));
          },
          child: SizedBox(
            width: 220,
            height: 270,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: 150,
                  width: double.infinity,
                  alignment: const Alignment(-0.9, -4.5),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              product!.images!.first!.toString()))),
                  // child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //   child: Center(
                  //     child: Image(

                  //         image: CachedNetworkImageProvider(
                  //             product!.images!.first!.toString())),
                  //   ),
                  // ),
                ),
                Positioned(
                  bottom: 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product!.name!,
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway'),
                      ),
                      const Text(
                        'Findd',
                        style:
                            TextStyle(color: Color(0xff868686), fontSize: 16.0),
                      ),
                      Text(
                        "${currencySymbol()} ${numberFormat.format(int.tryParse(product!.price!))}",
                        style: const TextStyle(
                            color: Color(0xff5956E9), fontSize: 17.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star_border_outlined,
                              color: Colors.orange,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.green,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            product!.stock! > 0 ? 'Available ' : 'UnAvailable',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
