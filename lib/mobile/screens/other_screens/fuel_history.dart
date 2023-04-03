import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/screens/purchase_screens/cart.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import '../../../responsive/responsive_config.dart';
import '../../../service/controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/fuel_widget.dart';



class FuelHistory extends StatefulWidget {
  const FuelHistory({Key? key}) : super(key: key);

  @override
  State<FuelHistory> createState() => _FuelHistoryState();
}

class _FuelHistoryState extends State<FuelHistory> {
  @override
  void initState() {
    super.initState();
    getCart(context);
  }

  Future getCart(BuildContext context) async {
    if (Provider.of<UiProvider>(context, listen: false).fuelOrders.isNotEmpty) {
      return;
    }
    await Controls.fuelHistoryController(context);
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
        title: const Text(
          "Fuel History",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Controls.fuelHistoryController(context),
        child: Stack(
          children: [
            context.watch<UiProvider>().fuelOrders.isNotEmpty
                ? Padding(
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
                            fit: BoxFit.contain)))
                : const SizedBox.shrink(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width * 0.15
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  FuelAlert(),
                  Expanded(
                    child: context.watch<UiProvider>().fuelOrders.isNotEmpty
                        ? ListView(
                            children: context
                                .watch<UiProvider>()
                                .fuelOrders
                                .map(
                                  (e) => FuelDeals(
                                    assetPath: 'assets/images/tablet.png',
                                    title: '2020 Apple iPad Air 10.9"',
                                    price: 579,
                                    product: e,
                                  ),
                                )
                                .toList())
                        : EmptyState(
                            path: 'assets/images/no_history.png',
                            title: 'No history yet',
                            description:
                                'Hit the blue button down below to Create an order',
                            textButton: 'Start ordering',
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
     
          ],
        ),
      ),
    );
  }
}
