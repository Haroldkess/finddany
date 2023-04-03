import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/fuel/model/fuel_model.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/models/order_model.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/service/constant.dart';

import '../../designParams/params.dart';
import '../../service/state/ui_manager.dart';

class FuelDeals extends StatelessWidget {
  final double price;
  final String title;
  final String assetPath;
  final FuelModel product;
  FuelDeals({
    Key? key,
    required this.product,
    this.price = 0,
    this.title = 'Title of the product',
    this.assetPath = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider provide = Provider.of<UiProvider>(context, listen: false);
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14),
      padding: EdgeInsets.all(0),
      minimumSize: const Size(22, 22),
      maximumSize: const Size(22, 22),
      elevation: 0,
      primary: Color(0xFF7DCCEC),
    );

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: [
                  const Image(
                    image: AssetImage("assets/images/tank.png"),
                    width: 80,
                    height: 105,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${currencySymbol()} ${numberFormat.format(int.tryParse(product.price!.toString()))}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF5956E9)),
                      ),
                      Row(
                        children: [
                          const Text('Lires: '),
                          Text(
                            product.litres.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(
                          product.address!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      provide.hasShop
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                product.email!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      const SizedBox(height: 5),
                      provide.hasShop
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                product.phone!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(
                          product.timestamp!.toDate().toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      provide.hasShop
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Text(
                                product.userId!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
              provide.hasShop
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.contacts_outlined,
                        //     size: 18,
                        //     color: Color(0xFFFA4A0C),
                        //   ),
                        //   onPressed: () async {
                        //     // Modals.deleteFromCart(context, product.id!);
                        //     // do something
                        //   },
                        // ),
                        InkWell(
                          onTap: () {
                            // Modals.deleteFromCart(context, product.id!);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: product.recieved!
                                    ? kPrimaryColor
                                    : Colors.orange,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                product.recieved! ? 'Recieved' : 'Processing',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : SizedBox.shrink(),
            ])),
      ),
    );
  }
}
