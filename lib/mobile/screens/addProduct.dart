import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/allNavigation.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/add_image.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/category.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/description_form.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/name_form.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/new_price.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/old_price.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/shop_name.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/shop_phone.dart';
import 'package:shoppingyou/mobile/widgets/addproduct/stock.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';

import '../../models/prod_model.dart';
import '../../responsive/responsive_config.dart';
import '../../service/state/ui_manager.dart';
import '../widgets/toast.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController oldPrice = TextEditingController();
  TextEditingController stock = TextEditingController();
  Color screenPickerColor = Colors.white;
  List<String> listColors = [];
  List<String> listSize = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  List<String> pickedSize = [];

  TextEditingController shopName = TextEditingController();
  TextEditingController shopPhone = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<void> cat() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/EllipseMorado.png')),
              ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.center,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: const Image(
                      image: AssetImage('assets/images/EllipseRosa.png'),
                      fit: BoxFit.contain)),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.white.withOpacity(0.8),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width * 0.2
                            : 20),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: Responsive.isDesktop(context) ? 50 : 0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () async {
                                        PageRouting.popToPage(context);
                                        //  Navigator.pushReplacementNamed(context, 'homeScreen');
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Color(0xff5956E9),
                                      )),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (Provider.of<UiProvider>(context,
                                        listen: false)
                                    .shopYouCategory
                                    .isEmpty) {
                                  ModalClass.CategoryChange(context);
                                  await Controls.getCategory(context);
                                } else {
                                  ModalClass.CategoryChange(context);
                                }
                              },
                              child: Text(
                                context.watch<UiProvider>().selectedCategory,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'Raleway',
                                    color: const Color(0xff5956E9),
                                    fontSize: Responsive.isMobile(context)
                                        ? 20
                                        : 20.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        context.watch<UiProvider>().images.isNotEmpty
                            ? FadeInRight(
                                animate: true,
                                duration: const Duration(milliseconds: 1000),
                                child: Row(
                                  children: [
                                    Text(
                                      'Only 3 of your selected images will be used...',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.red,
                                          fontSize: Responsive.isMobile(context)
                                              ? 15
                                              : 15.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        context.watch<UiProvider>().images.isEmpty
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: kPrimaryColor,
                                        width: 1.5,
                                        style: BorderStyle.solid)),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: kPrimaryColor,
                                    ),
                                    onPressed: () =>
                                        Utility.pickProductImages(context),
                                  ),
                                ),
                              )
                            : const AddImage(),
                        ProductName(controller: name),
                        ProductDescription(controller: desc),
                        ProductNewPrice(controller: price),
                        ProductOldPrice(controller: oldPrice),
                        ProductStock(controller: stock),
                        ProductShopName(controller: shopName),
                        ProductShopPhone(controller: shopPhone),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              'Pick only 5 colors',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: const Color(0xff5956E9),
                                  fontSize:
                                      Responsive.isMobile(context) ? 20 : 30.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  width: 1.5,
                                  color: kPrimaryColor,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: listColors.isNotEmpty
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: listColors
                                              .map((e) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            listColors
                                                                .removeWhere(
                                                                    (element) =>
                                                                        element ==
                                                                        e);
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              HexColor('#$e'),
                                                        )),
                                                  ))
                                              .toList()),
                                    )
                                  : Text(
                                      'Your Colors will appear here!',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          color: const Color(0xff5956E9),
                                          fontSize: Responsive.isMobile(context)
                                              ? 10
                                              : 10.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Card(
                              elevation: 2,
                              child: ColorPicker(
                                // Use the screenPickerColor as start color.
                                color: screenPickerColor,
                                colorCodeHasColor: true,
                                showColorName: true,

                                // Update the screenPickerColor using the callback.
                                onColorChanged: (Color color) async {
                                  if (listColors.length < 5) {
                                    setState(() => screenPickerColor = color);

                                    listColors.add(color.hex);
                                    log(color.hex);
                                  }
                                },
                                width: 44,
                                height: 44,
                                borderRadius: 22,
                                heading: Text(
                                  'Select color',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                subheading: Text(
                                  'Select color shade',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              'select sizes',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: const Color(0xff5956E9),
                                  fontSize:
                                      Responsive.isMobile(context) ? 20 : 30.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: listSize
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: InkWell(
                                          onTap: () async {
                                            if (!pickedSize.contains(e)) {
                                              setState(() {
                                                pickedSize.add(e);
                                              });
                                              print(pickedSize);
                                            } else {
                                              setState(() {
                                                pickedSize.removeWhere(
                                                    (element) => element == e);
                                              });
                                            }
                                          },
                                          child: Card(
                                            color: pickedSize.contains(e)
                                                ? const Color(0xff5956E9)
                                                : Colors.white,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  pickedSize.contains(e)
                                                      ? const Color(0xff5956E9)
                                                      : Colors.white,
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    color:
                                                        pickedSize.contains(e)
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          )),
                                    ))
                                .toList()),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    bool check = await Controls.verifyProdForm(
                                        context,
                                        desc.text,
                                        name.text,
                                        price.text,
                                        oldPrice.text,
                                        int.tryParse(stock.text)!);
                                    if (check == false) {
                                       // ignore: use_build_context_synchronously
                                       showToast2(context,  'Please fill in the form properly. ', isError: true);
                                      log('incorrect Form');
                                      return;
                                    }

                                    bool doThis =
                                        // ignore: use_build_context_synchronously
                                        await Controls.uploadProductInfo(
                                            context,
                                            desc.text,
                                            listColors,
                                            name.text,
                                            price.text,
                                            oldPrice.text,
                                            pickedSize,
                                            int.tryParse(stock.text)!);

                                    if (doThis) {
                                      setState(() {
                                        desc.clear();
                                        name.clear();
                                        price.clear();
                                        oldPrice.clear();
                                        stock.clear();
                                        listColors.clear();
                                        pickedSize.clear();
                                        shopName.clear();
                                        shopPhone.clear();
                                      });
                                      desc.clear();
                                      name.clear();
                                      price.clear();
                                      oldPrice.clear();
                                      stock.clear();
                                      listColors.clear();
                                      pickedSize.clear();
                                        shopName.clear();
                                        shopPhone.clear();
                                      // showToast('This Form will  reset!',
                                      //     successBlue);

                                      // ignore: use_build_context_synchronously
                                      // Navigator.pushReplacementNamed(
                                      //     context, "home");
                                    } else {}
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF5956E9),
                                      //  fixedSize: const Size( 70.0),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 22),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                  child: context.watch<UiProvider>().isLoading
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text('Post Product')),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
