import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/admin/adminextra/order_users.dart';

import '../../responsive/responsive_config.dart';
import '../../service/controller.dart';
import '../../service/state/ui_manager.dart';
import '../screens/purchase_screens/cart.dart';
import '../widgets/deal_item.dart';
import '../widgets/empty_state.dart';
import 'adminextra/admin_extra.dart';

class UserOrders extends StatefulWidget {
  final String name;
  final String id;
  const UserOrders({super.key, required this.name, required this.id});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  void initState() {
    super.initState();
    getCart(context);
  }

  Future getCart(BuildContext context) async {
    await Controls.doneAdminUserOrderController(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "${widget.name}, Orders",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Controls.doneAdminUserOrderController(context, widget.id),
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
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width * 0.15
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  InfoAlert(),
                  Expanded(
                    child: context.watch<UiProvider>().adminDeals.isNotEmpty
                        ? ListView(
                            children: context
                                .watch<UiProvider>()
                                .adminDeals
                                .map(
                                  (e) => AdminDealItem(
                                    assetPath: 'assets/images/tablet.png',
                                    title: '2020 Apple iPad Air 10.9"',
                                    price: 579,
                                    product: e,
                                    id: widget.id,
                                    adminDeals: context.watch<UiProvider>().adminDeals,
                                  ),
                                )
                                .toList())
                        : EmptyState(
                            path: 'assets/images/no_history.png',
                            title: 'This User has no order item',
                            description:
                                'Hit the blue button down below to Leave page',
                            textButton: 'Go Back',
                            onClick: () {
                              Navigator.pop(context);
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
