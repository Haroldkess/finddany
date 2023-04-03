import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView.builder(
          itemCount: context.watch<UiProvider>().images.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            color: kPrimaryColor,
                            width: 1.5,
                            style: BorderStyle.solid),
                      ),
                      child: Image.memory(
                          Provider.of<UiProvider>(context, listen: false)
                              .images[index]),
                    ),
                    Positioned(
                        top: 0.1,
                        right: 2.0,
                        child: IconButton(
                            onPressed: () async {
                              Provider.of<UiProvider>(context, listen: false)
                                  .removePickedProductPictures(index);
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            )))
                  ],
                ),
              )),
        ));
  }
}
