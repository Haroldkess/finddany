import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/button.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../../designParams/params.dart';
import '../../../models/prod_model.dart';
import '../../../service/controller.dart';
import '../../widgets/buttonmini.dart';

class SingleItem extends StatefulWidget {
  final ProductModel? product;
  const SingleItem({Key? key, required this.product}) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  List<String> selectedColor = [];
  List<String> selectedSize = [];
  @override
  void initState() {
    super.initState();
  }

  int selectedQty = 1;

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14),
      padding: EdgeInsets.all(0),
      minimumSize: const Size(44, 44),
      maximumSize: const Size(44, 44),
      elevation: 0,
      primary: Color(0xFF7DCCEC),
    );
    return Scaffold(
        backgroundColor: const Color(0xffF6F6F9),
        body: Container(
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: FractionalOffset.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: const Image(
                          image: AssetImage('assets/images/splash.png'),
                          fit: BoxFit.contain))),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            top: Responsive.isDesktop(context) ? 50 : 0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Color(0xff5956E9),
                                    )),
                              ),
                              SizedBox()
                            ],
                          ),
                        )),
                    Container(
                      child: CarouselWithIndicatorDemo(
                        product: widget.product,
                      ),
                      width: 300,
                      height: 280,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width * 0.2
                              : 0),
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          //  height: MediaQuery.of(context).size.height * 2,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        widget.product!.name!,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600),
                                      )),
                                  widget.product!.color!.isNotEmpty
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 39,
                                                  top: 12,
                                                  bottom: 10),
                                              child: Text(
                                                'Colors',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17,
                                                    fontFamily: 'Raleway'),
                                                textAlign: TextAlign.left,
                                              )))
                                      : const SizedBox.shrink(),
                                  widget.product!.color!.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: widget.product!.color!
                                              .map((e) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          selectedColor.clear();
                                                          selectedColor.add(e);
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: HexColor(
                                                                    '#$e'),
                                                                shape: BoxShape
                                                                    .circle,
                                                                // borderRadius:
                                                                //     BorderRadius
                                                                //         .circular(15),
                                                                border: Border.all(
                                                                    color: selectedColor
                                                                            .contains(
                                                                                e)
                                                                        ? kPrimaryColor
                                                                        : Colors
                                                                            .transparent,
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    width:
                                                                        4.0)),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        )
                                      : const SizedBox.shrink(),
                                  widget.product!.size!.isNotEmpty
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 39,
                                                  top: 12,
                                                  bottom: 10),
                                              child: Text(
                                                'Sizes',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17,
                                                    fontFamily: 'Raleway'),
                                                textAlign: TextAlign.left,
                                              )))
                                      : const SizedBox.shrink(),
                                  widget.product!.color!.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: widget.product!.size!
                                              .map((e) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            selectedSize
                                                                .clear();
                                                            selectedSize.add(e);
                                                          });
                                                        },
                                                        child: Card(
                                                          color: selectedSize
                                                                  .contains(e)
                                                              ? const Color(
                                                                  0xff5956E9)
                                                              : Colors.white,
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor:
                                                                selectedSize
                                                                        .contains(
                                                                            e)
                                                                    ? const Color(
                                                                        0xff5956E9)
                                                                    : Colors
                                                                        .white,
                                                            child: Text(
                                                              e,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Raleway',
                                                                  color: selectedSize
                                                                          .contains(
                                                                              e)
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                        )),
                                                  ))
                                              .toList())
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Quantity'),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: style,
                                        onPressed: () {
                                          if (selectedQty > 1) {
                                            setState(() {
                                              selectedQty--;
                                            });
                                          }
                                        },
                                        child: const Text('-'),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          selectedQty.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: style,
                                        onPressed: () {
                                          if (selectedQty <
                                              widget.product!.stock!) {
                                            setState(() {
                                              selectedQty++;
                                            });
                                          }
                                        },
                                        child: const Text('+'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  // Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 20, left: 45),
                                  //     child: Container(
                                  //         alignment: Alignment.centerLeft,
                                  //         child: const Text(
                                  //           'Become a vendor for free this',
                                  //           style: TextStyle(
                                  //               fontFamily: 'Raleway',
                                  //               fontWeight: FontWeight.w700,
                                  //               fontSize: 17),
                                  //         ))),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      widget.product!.description!,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                          color: Colors.black38),
                                    ),
                                  ),
                                  // Container(
                                  //     alignment: Alignment.topLeft,
                                  //     padding: const EdgeInsets.only(left: 45),
                                  //     child: ElevatedButton(
                                  //         style: ElevatedButton.styleFrom(
                                  //             primary: Colors.white,
                                  //             padding: EdgeInsets.all(0.0),
                                  //             elevation: 0.0),
                                  //         onPressed: () {},
                                  //         child: const Text(
                                  //           'Full description ->',
                                  //           style: TextStyle(
                                  //               color: Color(0xff5956E9),
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.w700,
                                  //               fontFamily: 'Raleway'),
                                  //         ))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 53, right: 50, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Raleway'),
                                          ),
                                          Text(
                                            '${currencySymbol()} ${numberFormat.format(int.tryParse(widget.product!.price!))}',
                                            style: const TextStyle(
                                                color: Color(0xff5956E9),
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Raleway'),
                                          ),
                                        ],
                                      )),
                                  context.watch<UiProvider>().loading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            CupertinoActivityIndicator(
                                              radius: 30,
                                              color: Color(0xff5956E9),
                                            ),
                                          ],
                                        )
                                      : Button(
                                          text: widget.product!.stock! < 1
                                              ? 'out of stock'
                                              : 'Add to basket',
                                          color: widget.product!.stock! < 1
                                              ? Colors.red
                                              : Color(0xff5956E9),
                                          width: 314,
                                          onClick: () async {
                                            bool value =
                                                await Controls.checkEnable(
                                                    context, 'oneGod1997');

                                            if (value == false) {
                                              showToast2(context,
                                                  'We are closed kindly come back tomorrow',
                                                  isError: true);
                                              return;
                                            }

                                            if (widget.product!.stock! < 1) {
                                              showToast2(
                                                  context, 'Out of stock',
                                                  isError: true);
                                              return;
                                            }
                                            if (widget.product!.color!
                                                    .isNotEmpty &&
                                                selectedColor.isEmpty) {
                                              showToast2(context,
                                                  'Please select a color',
                                                  isError: true);
                                              return;
                                            }
                                            if (widget.product!.size!
                                                    .isNotEmpty &&
                                                selectedSize.isEmpty) {
                                              showToast2(context,
                                                  'Please select a Size',
                                                  isError: true);
                                              return;
                                            }
                                            bool doThis =
                                                // ignore: use_build_context_synchronously
                                                await Controls.uploadToCart(
                                                    context,
                                                    widget.product!.id!,
                                                    widget
                                                        .product!.description!,
                                                    selectedColor,
                                                    widget.product!.name!,
                                                    widget.product!.price!,
                                                    widget.product!.oldPrice!,
                                                    selectedSize,
                                                    widget.product!.images!,
                                                    widget.product!.stock!,
                                                    selectedQty,
                                                    widget.product!.userId!);

                                            if (doThis) {
                                              // showToast2(context,
                                              //     'Kindly continue shopping',
                                              //     isError: false);
                                            } else {}
                                          },
                                          height: 60,
                                          fontSize: 20,
                                        )
                                ],
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2.0,
                right: 2.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Image(
                          image: AssetImage('assets/images/EllipseMorado.png')),
                      // ShaderMask(
                      //     shaderCallback: (rect) {
                      //       return const LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         end: FractionalOffset.center,
                      //         colors: [Colors.black, Colors.transparent],
                      //       ).createShader(rect);
                      //     },
                      //     blendMode: BlendMode.dstIn,
                      //     child: const Image(
                      //         image:
                      //             AssetImage('assets/images/EllipseRosa.png'),
                      //         fit: BoxFit.contain)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  final ProductModel? product;
  const CarouselWithIndicatorDemo({Key? key, required this.product})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: <Widget>[
        Expanded(
          child: CarouselSlider(
            items: widget.product!.images!
                .map((e) => CachedNetworkImage(imageUrl: e))
                .toList(),
            carouselController: _controller,
            options: CarouselOptions(
                height: 240,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.product!.images!
              .map((e) => CachedNetworkImage(imageUrl: e))
              .toList()
              .asMap()
              .entries
              .map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.transparent
                            : Colors.transparent)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
