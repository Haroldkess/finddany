import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../other_screens/no_history.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'My profile',
          style: TextStyle(
              fontFamily: 'Raleway',
              color: Color(0xff5956E9),
              fontSize: 18.0,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff5956E9),
          ),
        ),
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
                vertical: 0,
                horizontal: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width * 0.15
                    : 0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),

                  // const SizedBox(height: 60),
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 12),
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.topCenter,
                              fit: StackFit.loose,
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                ),
                                Positioned(
                                  top: -60,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: context
                                            .watch<UiProvider>()
                                            .imageUrl
                                            .isEmpty
                                        ? const AssetImage(
                                                'assets/images/avatar.png')
                                            as ImageProvider
                                        : CachedNetworkImageProvider(context
                                            .watch<UiProvider>()
                                            .imageUrl),
                                  ),
                                )
                              ],
                            ),
                            context.watch<UiProvider>().isLoading
                                ? const CupertinoActivityIndicator(
                                    radius: 30,
                                    color: kPrimaryColor,
                                  )
                                : InkWell(
                                    onTap: () {
                                      Utility.pickProfileImage(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Tap to change',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Raleway',
                                            color: Color(0xFF5956E9),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                            Text(
                              context.watch<UiProvider>().name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const Icon(Icons.location_on_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        const Text('Address: '),
                                        SizedBox(
                                          width: Responsive.isDesktop(context)
                                              ? null
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                          child: Text(
                                            context
                                                        .watch<UiProvider>()
                                                        .address ==
                                                    'null'
                                                ? 'Your address added'
                                                : context
                                                    .watch<UiProvider>()
                                                    .address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Responsive.isDesktop(context)
                                          ? null
                                          : MediaQuery.of(context).size.width /
                                              1.5,
                                      child: Text(context
                                                  .watch<UiProvider>()
                                                  .phoneNumber ==
                                              'null'
                                          ? 'No Phone'
                                          : context
                                              .watch<UiProvider>()
                                              .phoneNumber),
                                    ),
                                    SizedBox(
                                      width: Responsive.isDesktop(context)
                                          ? null
                                          : MediaQuery.of(context).size.width /
                                              1.5,
                                      child: Text(context
                                                  .watch<UiProvider>()
                                                  .email ==
                                              'null'
                                          ? 'No Email'
                                          : context.watch<UiProvider>().email),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                  ProfileOption(
                      text: 'Edit Profile',
                      onClick: () {
                        Modals.editProfileInfo(context);
                      }),
                  ProfileOption(
                      text: 'Shipping address',
                      onClick: () {
                        Modals.shipping(context);
                      }),
                  ProfileOption(
                      text: 'Order history',
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoneDeals()));
                      }),
                  ProfileOption(
                      text: 'Cards',
                      onClick: () {
                        Modals.cards(context);
                      }),
                  ProfileOption(
                      text: 'Notifications',
                      onClick: () {
                        Modals.notification(context);
                      }),
                ],
              ),
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
                ],
              ),
            ),
          )
       
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final VoidCallback? onClick;
  final String text;
  ProfileOption({
    Key? key,
    this.onClick,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
      child: ListTile(
        // contentPadding: EdgeInsets.all(10),

        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onTap: onClick,
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        tileColor: Colors.white,
      ),
    );
  }
}
