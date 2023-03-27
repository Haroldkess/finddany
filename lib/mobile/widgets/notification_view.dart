import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/models/order_model.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/service/constant.dart';

class NotificationItem extends StatelessWidget {
  final double price;
  final String title;
  final String assetPath;

  NotificationItem({
    Key? key,
   
    this.price = 0,
    this.title = 'Title of the product',
    this.assetPath = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(
                           assetPath),
                        width: 80,
                        height: 105,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                               child: Text(
                                  title,
                                   maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                             ),
                           
    
                        ],
                      ),
                  
                  
                    ],
                  ),
        
                ])),
      ),
    );
  }
}
