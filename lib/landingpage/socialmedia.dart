
import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppingyou/service/constant.dart';


class SocialMedia extends StatefulWidget {
  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  String? link;

  // _launchInWebViewOrVC(String urlLink) async {
  //   link = urlLink;

  //   if (await canLaunch(link!)) {
  //     await launch(
  //       link!,
  //       forceSafariVC: false,
  //       forceWebView: false,
  //       headers: <String, String>{'my_header_key': 'my_header_value'},
  //     );
  //   } else {
  //     throw 'Could not launch $link';
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: ()
            {
              //_launchInWebViewOrVC('https://twitter.com/Catchpay8');
            },
            child: IconHolder(
              icon: AntIcons.twitter_circle,

            ),
          ),
          GestureDetector(
            onTap: ()
            {
            //  _launchInWebViewOrVC('https://t.me/CatchPay');

            },
            child: IconHolder(
              icon: FontAwesomeIcons.telegram,
            ),
          ),
          GestureDetector(
            onTap: ()
            {
            //  _launchInWebViewOrVC('https://www.instagram.com/catchpay/');
            },
            child: IconHolder(
              icon: AntIcons.instagram,
            ),
          ),
        ],
      ),
    );
  }
}

class IconHolder extends StatefulWidget {
  final IconData? icon;

  IconHolder({this.icon});

  @override
  _IconHolderState createState() => _IconHolderState();
}

class _IconHolderState extends State<IconHolder> {
  Color? color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (a) {
        setState(() {
          color = Colors.black;
        });
      },
      onExit: (a) {
        setState(() {
          color = Colors.white;
        });
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Icon(
          widget.icon,
          size: 26.0,
          color: color,
        ),
      ),
    );
  }
}
