import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
///
///
class SocialGistLogo extends StatelessWidget {
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;

  ///
  ///
  ///
  const SocialGistLogo({
    this.fontSize = 24,
    this.mainAxisAlignment = MainAxisAlignment.center,
    Key key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Text(
          'Social',
          style: GoogleFonts.openSans(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: fontSize / 9.0),
          child: Text(
            'Gist',
            style: GoogleFonts.openSans(
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
