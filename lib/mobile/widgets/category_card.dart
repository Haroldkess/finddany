import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/designParams/params.dart';
import 'package:shoppingyou/mobile/screens/product/singleitemscreen.dart';
import 'package:shoppingyou/models/prod_model.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';

import '../../models/fake_user.dart';

class Stories extends StatefulWidget {
  final User currentUser;
  final List<Story> stories;
  final double height;

  const Stories(
      {Key? key,
      required this.currentUser,
      required this.stories,
      required this.height})
      : super(key: key);

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context) || Responsive.isMobileLarge(context)
          ? widget.height * 0.3
          : widget.height * 0.4,

      // color:  Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          context.watch<UiProvider>().prod.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    // padding: const EdgeInsets.symmetric(
                    //   vertical: 10.0,
                    //   horizontal: 8.0,
                    // ),
                    scrollDirection: Axis.horizontal,
                    itemCount: context.watch<UiProvider>().quickPicks.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel story =
                          Provider.of<UiProvider>(context, listen: false)
                              .quickPicks[index];
                      return Padding(
                        padding: EdgeInsets.only(right: onlyAllPadding),
                        child: _StoryCard(story: story),
                      );
                    },
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'We will pick some Products in a moment',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: const Color(0xff5956E9),
                          fontSize: Responsive.isMobile(context) ? 20 : 15.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Image.asset('images/itemnotfound.png'),
                  ],
                ),
          Responsive.isMobile(context)
              ? const SizedBox.shrink()
              : const Positioned(
                  right: 2.0,
                  child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xff5956E9),
                      ))),
          Responsive.isMobile(context)
              ? const SizedBox.shrink()
              : const Positioned(
                  left: 2.0,
                  child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Color(0xff5956E9),
                      ))),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User? currentUser;
  final ProductModel? story;

  const _StoryCard({
    Key? key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  var theme = MyThemes.darkTheme.primaryColorDark;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleItem(
                      product: story,
                    )));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: story!.images!.first,
              height: double.infinity,
              width: Responsive.isDesktop(context)
                  ? width * 0.1
                  : Responsive.isTablet(context)
                      ? width * 0.15
                      : width * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: Responsive.isDesktop(context)
                ? width * 0.1
                : Responsive.isTablet(context)
                    ? width * 0.15
                    : width * 0.25,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black26],
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 8.0,
            right: 8.0,
            child: ProfileAvatar(
              imageUrl: story!.images!.first,
              hasBorder: true,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var theme = MyThemes.lightTheme.primaryColor;
    return CircleAvatar(
      radius: 20.0,
      backgroundColor: Colors.orange,
      child: CircleAvatar(
        radius: hasBorder ? 18.0 : 18.0,
        backgroundColor: Colors.grey[200],
        backgroundImage: CachedNetworkImageProvider(imageUrl),
      ),
    );
  }
}
