import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/database_service.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../../designParams/params.dart';
import '../../../responsive/responsive_config.dart';
import '../../../service/constant.dart';
import '../../widgets/button.dart';
import '../../widgets/cart_item.dart';
import '../../widgets/toast.dart';
import 'checkout.dart';

// Carrito de compras
class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    getCart(context);
  }

  Future getCart(BuildContext context) async {
    if (Provider.of<UiProvider>(context, listen: false).cartList.isNotEmpty) {
      return;
    }
    await Controls.cartCollectionControl(context)
        .whenComplete(() => DatabaseService.getDeliveryPrices(context));
    // ignore: use_build_context_synchronously
    await DatabaseService.getDeliveryPrices(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F8),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff5956E9),
          ),
        ),
        title: const Text(
          "Basket",
          style: TextStyle(
            color: Color(0xff5956E9),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(
          //     Icons.delete_outline,
          //     size: 28,
          //     color: Color(0xFFFA4A0C),
          //   ),
          //   onPressed: () {
          //     // do something
          //   },
          // ),
          // const SizedBox(width: 8)
        ],
      ),
      body: Stack(
        children: [
          // Padding(
          //     padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
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
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width * 0.15
                    : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                CartInfoAlert(),
                Expanded(
                  child: context.watch<UiProvider>().cartList.isNotEmpty
                      ? ListView(
                          children: context
                              .watch<UiProvider>()
                              .cartList
                              .map(
                                (e) => CartItem(
                                  assetPath: 'assets/images/tablet.png',
                                  title: '2020 Apple iPad Air 10.9"',
                                  price: 579,
                                  product: e,
                                ),
                              )
                              .toList())
                      : Column(
                          children: const [
                            Center(
                              child: CupertinoActivityIndicator(
                                color: Color(0xFF5956E9),
                                radius: 30,
                              ),
                            ),
                            Text(
                              'Nothing in your cart',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
                context.watch<UiProvider>().cartList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Total',
                              style: TextStyle(fontSize: 17),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${currencySymbol()}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5956E9),
                                  ),
                                ),
                                Text(
                                  numberFormat.format(int.tryParse(context
                                      .watch<UiProvider>()
                                      .totalPrice
                                      .toString())),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5956E9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 30),
                context.watch<UiProvider>().cartList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LargeButton(
                          text: 'Checkout',
                          onClick: () async {
                            if (Provider.of<UiProvider>(context, listen: false)
                                .cartList
                                .isEmpty) {
                              Navigator.pop(context);
                              showToast2(context, "Kindly add product to cart",
                                  isError: true);
                              return;
                            }
                            bool value = await Controls.checkEnable(
                                context, 'oneGod1997');

                            if (value == false) {
                              // ignore: use_build_context_synchronously
                              showToast2(context,
                                  'We are closed kindly come back tomorrow',
                                  isError: true);
                              return;
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Checkout()),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 20)
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
                  //         image: AssetImage('assets/images/EllipseRosa.png'),
                  //         fit: BoxFit.contain)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InfoAlert extends StatelessWidget {
  const InfoAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Card(
          color: const Color(0XFFD3F2FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
                iconSize: 28,
              ),
              const Text(
                'Relax. Your order will be delivered shortly',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 12)
            ],
          ),
        ));
  }
}

class CartInfoAlert extends StatelessWidget {
  const CartInfoAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Card(
          color: const Color(0XFFD3F2FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
                iconSize: 28,
              ),
              const Text(
                'Process cart before 5pm, for quick delivery',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 12)
            ],
          ),
        ));
  }
}

class FuelAlert extends StatelessWidget {
  const FuelAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Card(
          color: const Color(0XFFD3F2FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
                iconSize: 28,
              ),
              const Text(
                'Relax. Your fuel will be delivered shortly',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 12)
            ],
          ),
        ));
  }
}

class FuelAlertError extends StatelessWidget {
  const FuelAlertError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.withOpacity(0.4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined,
                  color: Colors.white),
              onPressed: () {},
              iconSize: 28,
            ),
            const Expanded(
              child: Text(
                'Incorrect phone number can delay delivery',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FuelAlertError2 extends StatelessWidget {
  const FuelAlertError2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.withOpacity(0.8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {},
              iconSize: 28,
            ),
            const Expanded(
              child: Text(
                'Do not exit page or close browser when your transaction/payment is being processed',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
