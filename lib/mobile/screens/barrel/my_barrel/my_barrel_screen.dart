// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/mobile/screens/barrel/barrel_controller/barrels_controller.dart';
import 'package:shoppingyou/mobile/screens/barrel/barrel_widget.dart';
import 'package:shoppingyou/mobile/screens/purchase_screens/cart.dart';
import 'package:shoppingyou/mobile/widgets/pop_up.dart';
import 'dart:math';

import 'package:shoppingyou/mobile/widgets/text.dart';
import 'package:shoppingyou/models/user_model.dart';
import 'package:shoppingyou/service/auth_notifier.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/firebase_calls.dart';
import 'package:shoppingyou/service/operations.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class BarrelScreen extends StatefulWidget {
  @override
  _BarrelScreenState createState() => _BarrelScreenState();
}

class _BarrelScreenState extends State<BarrelScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;
  late AnimationController _levelController;
  double _currentLiters = 0;

  bool load = false;

  @override
  void initState() {
    super.initState();

    // Wave Animation Controller
    _waveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely for continuous wave motion.

    _waveAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_waveController)
          ..addListener(() {
            setState(() {});
          });

    // Liquid Level Animation Controller
    _levelController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), () {
        fillBarrel(BarrelController.instance.myBarrel.value.litre == null
            ? 5.0
            : BarrelController.instance.myBarrel.value.litre!.toDouble());
      });
    });
  }

  void fillBarrel(double liters) {
    final targetLiters = (_currentLiters + liters).clamp(0, 50);
    _levelController.stop();
    _levelController.duration = const Duration(seconds: 2);

    _levelController.addListener(() {
      setState(() {
        _currentLiters = Tween<double>(
          begin: _currentLiters,
          end: targetLiters.toDouble(),
        ).animate(_levelController).value;
      });
    });

    _levelController.forward(from: 0);
  }

  void reduceBarrel(double liters) {
    final targetLiters = (_currentLiters - liters).clamp(0, 50);
    _levelController.stop();
    _levelController.duration = const Duration(seconds: 2);

    _levelController.addListener(() {
      setState(() {
        _currentLiters = Tween<double>(
          begin: _currentLiters,
          end: targetLiters.toDouble(),
        ).animate(_levelController).value;
      });
    });

    _levelController.forward(from: 0);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: "My Barrel",
          size: 14,
          weight: FontWeight.bold,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();

                DocumentSnapshot data = await FirebaseCalls.getUserById(
                    id: pref.getString(userIdKey)!, collection: "users");

                UserModel user = UserModel.fromDoc(data);
                //  print(user.id);

                if (user.verifiedUser == false) {
                  AppSnackBar.snackBar(
                      message: "Your account status is not verified",
                      head: "Please proceed to verify status",
                      isError: true);
                  launchEmail(
                      toEmail: "Vigortechapp@gmail.com",
                      subject: "Verification",
                      message:
                          "i am requesting a verification for my quickly account here is my bvn:{input bvn}, bankName:{input bank name},accountNumber: {input account number}, fullname: {input full name}   and  below are my nin id card, and bank statement , ");
                } else {
                  AppSnackBar.snackBar(
                      message: "Your account status is already verified",
                      head: "Status",
                      isError: false);
                }
              },
              child: const Row(
                children: [
                  AppText(text: "Check Status"),
                ],
              ))
        ],
      ),
      body: GetBuilder(
          init: BarrelController(),
          builder: (myBarrel) {
            return myBarrel.myBarrel.value.id == null
                ? Center(
                    child: GestureDetector(
                        onTap: () {
                          BarrelWidgets.buyBarrelSheet(context);
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 15),
                              SizedBox(width: 3),
                              AppText(text: "Own your barrel.")
                            ])))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text:
                                  "Cap: ${currencySymbol()}${myBarrel.myBarrel.value.invested == null ? "" : myBarrel.myBarrel.value.invested!.isNegative ? "" : numberFormat.format(myBarrel.myBarrel.value.invested)}",
                              size: 14,
                              color: Colors.black,
                              weight: FontWeight.w600,
                            ),
                            AppText(
                              text:
                                  "Roi: ${currencySymbol()}${myBarrel.myBarrel.value.returns == null ? "" : myBarrel.myBarrel.value.returns!.isNegative ? "" : numberFormat.format(myBarrel.myBarrel.value.returns)} ",
                              size: 14,
                              color: Colors.black,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 200,
                              child: Image.asset(
                                'assets/images/barrel.png',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomPaint(
                              size: const Size(30, 120),
                              painter: BarrelPainter(
                                  _currentLiters, _waveAnimation.value),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const FuelAlertError2(
                          alert:
                              "Welcome to your oil business scale as you desire!",
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            AppText(
                              text: "Stats ",
                              size: 14,
                              color: Colors.black,
                              weight: FontWeight.w800,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BarrelStats(
                              title: "Barrel owned",
                              data: myBarrel.myBarrel.value.barrelOwned == null
                                  ? "cal.."
                                  : myBarrel.myBarrel.value.barrelOwned
                                      .toString(),
                              iconColor: Colors.brown,
                              tap: () {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            BarrelStats(
                              title: "Liters",
                              data: myBarrel.myBarrel.value.litre == null
                                  ? "cal.."
                                  : myBarrel.myBarrel.value.litre.toString(),
                              iconColor: Colors.brown,
                              tap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BarrelStats(
                              title: "Maintain",
                              data: myBarrel.myBarrel.value.expires == null
                                  ? "Cal.."
                                  : Operations.convertDate(myBarrel
                                      .myBarrel.value.expires!
                                      .toDate()),
                              iconColor: Colors.brown,
                              tap: () {},
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            BarrelStats(
                              title: "Expiry",
                              data: myBarrel.myBarrel.value.finalExpiration ==
                                      null
                                  ? "Cal..."
                                  : Operations.convertDate(myBarrel
                                      .myBarrel.value.finalExpiration!
                                      .toDate()),
                              iconColor: Colors.brown,
                              tap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        load
                            ? Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator.adaptive(
                                    valueColor: AlwaysStoppedAnimation(
                                        Colors.blue[900]),
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff5956E9),
                                    fixedSize: const Size(314.0, 80.0),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22),
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                child: const Text(
                                  "Request payout",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: myBarrel.myBarrel.value.returns! <
                                            2000 &&
                                        myBarrel.myBarrel.value.expires!
                                                .toDate()
                                                .compareTo(BarrelController
                                                    .instance
                                                    .myBarrel
                                                    .value
                                                    .expires!
                                                    .toDate()
                                                    .add(const Duration(
                                                        days: 3))) <
                                            0
                                    ? () async {
                                        AppSnackBar.snackBar(
                                            message:
                                                'You are not due for a payout yet.',
                                            head: "Not due yet",
                                            isError: false);

                                        return;
                                      }
                                    : () async {
                                        setState(() {
                                          load = true;
                                        });
                                        AppSnackBar.snackBar(
                                            message:
                                                'Send a request only once. or your payout will be delayed',
                                            head: "Warning",
                                            isError: false);
                                        try {
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();

                                          DocumentSnapshot data =
                                              await FirebaseCalls.getUserById(
                                                  id: pref
                                                      .getString(userIdKey)!,
                                                  collection: "users");

                                          UserModel user =
                                              UserModel.fromDoc(data);
                                          bool value =
                                              await Controls.checkEnable(
                                                  context, 'oneGod1997');

                                          await BarrelController.instance
                                              .getBarrel(referesh: true);
                                          // ignore: use_build_context_synchronously

                                          if (value == false) {
                                            // ignore: use_build_context_synchronously
                                            AppSnackBar.snackBar(
                                                message:
                                                    'We are closed kindly come back tomorrow',
                                                head: "Closed",
                                                isError: true);
                                            return;
                                          }

                                          if (user.verifiedUser == true) {
                                            if ((BarrelController.instance
                                                        .myBarrel.value.expires!
                                                        .toDate()
                                                        .compareTo(BarrelController
                                                            .instance
                                                            .myBarrel
                                                            .value
                                                            .expires!
                                                            .toDate()
                                                            .add(const Duration(
                                                                days: 3))) <=
                                                    0 &&
                                                BarrelController
                                                        .instance
                                                        .myBarrel
                                                        .value
                                                        .returns! >
                                                    2000)) {
                                              launchEmail(
                                                  toEmail:
                                                      "Vigortechapp@gmail.com",
                                                  subject: "Requesting Payout",
                                                  message:
                                                      "i am requesting for a payout of Naira ${BarrelController.instance.myBarrel.value.returns}");
                                            } else {
                                              AppSnackBar.snackBar(
                                                  message:
                                                      'You are not due for a payout yet',
                                                  head: "Not due",
                                                  isError: true);

                                              return;
                                            }
                                          } else {
                                            if ((BarrelController.instance
                                                        .myBarrel.value.expires!
                                                        .toDate()
                                                        .compareTo(BarrelController
                                                            .instance
                                                            .myBarrel
                                                            .value
                                                            .expires!
                                                            .toDate()
                                                            .add(const Duration(
                                                                days: 3))) <=
                                                    0 &&
                                                BarrelController
                                                        .instance
                                                        .myBarrel
                                                        .value
                                                        .returns! <
                                                    2000)) {
                                              launchEmail(
                                                  toEmail:
                                                      "Vigortechapp@gmail.com",
                                                  subject: "Verification",
                                                  message:
                                                      "i am requesting a verification for my quickly account here is my bvn:{input bvn}, bankName:{input bank name},accountNumber: {input account number}, fullname: {input full name}   and  below are my nin id card, and bank statement , ");

                                              return;
                                            } else {
                                              AppSnackBar.snackBar(
                                                  message:
                                                      'You are not due for a payout yet',
                                                  head: "Not due",
                                                  isError: true);

                                              return;
                                            }
                                          }
                                        } catch (e) {
                                          setState(() {
                                            load = false;
                                          });
                                        }

                                        setState(() {
                                          load = false;
                                        });
                                      },
                              ),
                      ],
                    ).paddingAll(15),
                  );
          }),
      floatingActionButton: GetBuilder(
          init: BarrelController(),
          builder: (barrel) {
            return barrel.myBarrel.value.id == null
                ? SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          if (barrel.myBarrel.value.id != null) {
                            if (Timestamp.now().toDate().compareTo(barrel
                                        .myBarrel.value.created!
                                        .toDate()
                                        .add(const Duration(days: 5))) <=
                                    0 &&
                                barrel.myBarrel.value.repaired == true) {
                              bool value = await Controls.checkEnable(
                                  context, 'oneGod1997');

                              await barrel.getBarrel(referesh: true);

                              if (barrel.myBarrel.value.litre! > 1) {
                                AppSnackBar.snackBar(
                                    message: 'You still have unsold oil.',
                                    head: "InStock",
                                    isError: true);

                                return;
                              } else {
                                if (Timestamp.now().toDate().compareTo(barrel
                                        .myBarrel.value.finalExpiration!
                                        .toDate()) >=
                                    0) {
                                  AppSnackBar.snackBar(
                                      message:
                                          'Your sales session has ended please get a new barrel',
                                      head: "Closed",
                                      isError: true);
                                  BarrelWidgets.buyBarrelSheet(context);
                                } else {
                                  if (value == false) {
                                    // ignore: use_build_context_synchronously
                                    AppSnackBar.snackBar(
                                        message:
                                            'We are closed kindly come back tomorrow',
                                        head: "Closed",
                                        isError: true);
                                    return;
                                  }
                                  if (barrel.myBarrel.value.repaired == false) {
                                    AppSnackBar.snackBar(
                                        message:
                                            'Please repair your barrel first before refill',
                                        head: "Closed",
                                        isError: true);
                                    return;
                                  }
                                  barrel.changeType("");
                                  if (barrel.myBarrel.value.litre! < 1) {
                                    if (barrel.myBarrel.value.paid == false) {
                                      if (kIsWeb) {
                                        // ignore: use_build_context_synchronously
                                        await barrel.makePayment(context,
                                            barrel.barrel.value.perLitre! * 50);
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        await barrel.makePaymentMobile(context,
                                            barrel.barrel.value.perLitre! * 50);
                                      }
                                      fillBarrel(barrel.myBarrel.value.litre!
                                          .toDouble());
                                    } else {
                                      barrel.refillBarrel();
                                      fillBarrel(barrel.myBarrel.value.litre!
                                          .toDouble());
                                    }
                                  }
                                }
                              }
                              // ignore: use_build_context_synchronously
                            } else {
                              if (Timestamp.now().toDate().compareTo(barrel
                                      .myBarrel.value.finalExpiration!
                                      .toDate()) >=
                                  0) {
                                AppSnackBar.snackBar(
                                    message:
                                        'Your sales session has ended please get a new barrel',
                                    head: "Closed",
                                    isError: true);
                                BarrelWidgets.buyBarrelSheet(context);
                              } else {
                                AppSnackBar.snackBar(
                                    message: "You took too long to refill.",
                                    head: "Repair",
                                    isError: true);
                                barrel.changeType("repair");

                                if (kIsWeb) {
                                  // ignore: use_build_context_synchronously
                                  await barrel.makePayment(
                                      context, barrel.barrel.value.repair!);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  await barrel.makePaymentMobile(
                                      context, barrel.barrel.value.repair!);
                                }
                              }
                            }
                          }
                        },
                        child: const Icon(
                          Icons.water_drop,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        backgroundColor: Colors.red[900],
                        onPressed: () async {
                          if (barrel.myBarrel.value.id != null) {
                            if (Timestamp.now().toDate().compareTo(barrel
                                        .myBarrel.value.expires!
                                        .toDate()) >=
                                    0 &&
                                barrel.myBarrel.value.repaired == false) {
                              bool value = await Controls.checkEnable(
                                  context, 'oneGod1997');

                              await barrel.getBarrel(referesh: true);

                              if (barrel.myBarrel.value.expires!
                                      .toDate()
                                      .compareTo(barrel.myBarrel.value.expires!
                                          .toDate()
                                          .add(const Duration(days: 3))) >=
                                  0) {
                                AppSnackBar.snackBar(
                                    message:
                                        'Your barrel was left in a bad shape for too long.',
                                    head: "Renewal needed",
                                    isError: true);

                                // ignore: use_build_context_synchronously
                                BarrelWidgets.buyBarrelSheet(context);
                              } else {
                                if (value == false) {
                                  // ignore: use_build_context_synchronously
                                  AppSnackBar.snackBar(
                                      message:
                                          'We are closed kindly come back tomorrow',
                                      head: "Closed",
                                      isError: true);
                                  return;
                                }
                                barrel.changeType("repair");

                                if (kIsWeb) {
                                  // ignore: use_build_context_synchronously
                                  await barrel.makePayment(
                                      context, barrel.barrel.value.repair!);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  await barrel.makePaymentMobile(
                                      context, barrel.barrel.value.repair!);
                                }
                              }
                              // ignore: use_build_context_synchronously
                            } else {
                              AppSnackBar.snackBar(
                                  message:
                                      "Your barrel is not due for maintainance.",
                                  head: "Not due",
                                  isError: true);
                            }
                          }
                        },
                        child: const Icon(
                          Icons.handyman,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
          }),
    );
  }

  Future launchEmail(
      {String? toEmail, String? subject, String? message}) async {
    final url =
        'mailTo:$toEmail?subject=${Uri.encodeFull(subject!)}&body=${Uri.encodeFull(message!)}';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

// ignore: must_be_immutable
class BarrelStats extends StatelessWidget {
  VoidCallback? tap;
  String? data;
  String? title;
  Color? iconColor;

  BarrelStats({
    super.key,
    this.tap,
    this.data,
    this.iconColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 96,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: data ?? "",
              size: 16,
              weight: FontWeight.w600,
              lines: 1,
            ).paddingSymmetric(horizontal: 5),
            const SizedBox(
              height: 5,
            ),
            AppText(
              text: title ?? "",
              size: 11,
              weight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}

class BarrelPainter extends CustomPainter {
  final double liters;
  final double wavePhase;

  BarrelPainter(this.liters, this.wavePhase);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.grey.shade300;
    Rect barrelRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(barrelRect, paint);

    Paint liquidPaint = Paint()..color = Colors.black.withOpacity(.3);
    double liquidHeight = (liters / 50) * size.height;

    Path liquidPath = Path();
    liquidPath.moveTo(0, size.height - liquidHeight);
    for (double i = 0; i <= size.width; i++) {
      liquidPath.lineTo(
        i,
        size.height -
            liquidHeight +
            sin((i / size.width) * 2 * pi + wavePhase) * 5,
      );
    }
    liquidPath.lineTo(size.width, size.height);
    liquidPath.lineTo(0, size.height);
    liquidPath.close();

    canvas.drawPath(liquidPath, liquidPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
