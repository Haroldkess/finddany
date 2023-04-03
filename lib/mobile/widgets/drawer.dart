import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';

import '../../service/state/ui_manager.dart';

class AppDrawer extends StatefulWidget {
  final Widget child;
  AppDrawer({key, required this.child}) : super(key: key);

  static _AppDrawerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppDrawerState>();

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  static Duration duration = Duration(milliseconds: 300);
  late AnimationController _controller;
  static const double maxSlide = 255;
  static const dragRightStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: _AppDrawerState.duration);
    super.initState();
  }

  void close() => _controller.reverse();

  void open() => _controller.forward();

  void toggle() {
    if (_controller.isCompleted) {
      close();
    } else {
      open();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails startDetails) {
    bool isDraggingFromLeft = _controller.isDismissed &&
        startDetails.globalPosition.dx < dragRightStartVal;
    bool isDraggingFromRight = _controller.isCompleted &&
        startDetails.globalPosition.dx > dragLeftStartVal;
    shouldDrag = isDraggingFromLeft || isDraggingFromRight;
  }

  void _onDragUpdate(DragUpdateDetails updateDetails) {
    if (shouldDrag == false) {
      return;
    }
    double delta = updateDetails.primaryDelta! / maxSlide;
    _controller.value += delta;
  }

  void _onDragEnd(DragEndDetails dragEndDetails) {
    if (_controller.isDismissed || _controller.isCompleted) {
      return;
    }

    double _kMinFlingVelocity = 365.0;
    double dragVelocity = dragEndDetails.velocity.pixelsPerSecond.dx.abs();

    if (dragVelocity >= _kMinFlingVelocity) {
      double visualVelocityInPx = dragEndDetails.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _controller.fling(velocity: visualVelocityInPx);
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          double animationVal = _controller.value;
          double translateVal = animationVal * maxSlide;
          double scaleVal = 1 - (animationVal * 0.3);
          return Stack(
            children: <Widget>[
              CustomDrawer(),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..translate(translateVal)
                  ..scale(scaleVal),
                child: GestureDetector(
                    onTap: () {
                      if (_controller.isCompleted) {
                        close();
                      }
                    },
                    child: widget.child),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UiProvider provide = Provider.of<UiProvider>(context, listen: false);
    return Material(
      color: Color(0xff5956E9),
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 52, bottom: 30),
                    child: Image(
                      image: AssetImage('assets/images/EllipseMorado.png'),
                    ),
                  )
                ],
              ),

              // ListTile(
              //   onTap: () {
              //     Navigator.pushNamed(context, 'deals');
              //   },
              //   leading: Icon(Icons.shopping_basket_outlined),
              //   title: Text(
              //     'My Orders',
              //     style: TextStyle(
              //       fontFamily: 'Raleway',
              //     ),
              //   ),
              // ),
              // Container(
              //     width: 206,
              //     child: const Padding(
              //       padding: EdgeInsets.only(left: 74, right: 0),
              //       child: Divider(
              //         color: Color(0xfff4f4f8),
              //       ),
              //     )),
              // ListTile(
              //   onTap: () {
              //     Navigator.pushNamed(context, 'profile');
              //   },
              //   leading: const Icon(Icons.settings_outlined),
              //   title: const Text(
              //     'Profile',
              //     style: TextStyle(
              //       fontFamily: 'Raleway',
              //     ),
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.center,
              //   child: Image(
              //     image: AssetImage('assets/images/EllipseMorado.png'),
              //   ),
              // ),

              Container(
                padding: EdgeInsets.only(left: 38, top: 17, bottom: 50),
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: context.watch<UiProvider>().imageUrl.isEmpty
                      ? const AssetImage('assets/images/avatar.png')
                          as ImageProvider
                      : CachedNetworkImageProvider(
                          context.watch<UiProvider>().imageUrl),
                ),
              ),

              provide.hasShop
                  ? ListTile(
                      onTap: () => Navigator.pushNamed(context, 'Admin'),
                      leading: Icon(Icons.dashboard),
                      title: Text(
                        'Vendor',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              provide.hasShop
                  ? Container(
                      width: 206,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 74, right: 0),
                        child: Divider(
                          color: Color(0xfff4f4f8),
                        ),
                      ))
                  : SizedBox.shrink(),
                   ListTile(
                onTap: () => Navigator.pushNamed(context, 'Fuel'),
                leading: const  Icon(FontAwesomeIcons.gasPump),
                title:  const Text(
                  'Fuel Orders',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
              Container(
                  width: 206,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 74, right: 0),
                    child: Divider(
                      color: Color(0xfff4f4f8),
                    ),
                  )),

              ListTile(
                onTap: () => Modals.sendFeedBack(context, controller),
                leading: const Icon(Icons.feedback_outlined),
                title: const Text(
                  'Feedback',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
              Container(
                  width: 206,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 74, right: 0),
                    child: Divider(
                      color: Color(0xfff4f4f8),
                    ),
                  )),

              ListTile(
                onTap: () {
                  Modals.logOutOption(context);
                },
                leading: Icon(Icons.logout),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
