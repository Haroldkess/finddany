import 'package:flutter/cupertino.dart';

class AppText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final int? lines;
  final TextAlign? align;
  const AppText(
      {super.key,
      this.text,
      this.color,
      this.size,
      this.weight,
      this.lines,
      this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      maxLines: lines,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontFamily: 'Raleway',
          fontSize: size,
          fontWeight: weight),
    );
  }
}
