import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
///
///
class ScaffoldBottomTitle extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  ///
  ///
  ///
  @override
  final Size preferredSize;

  ///
  ///
  ///
  const ScaffoldBottomTitle(
    this.title, {
    this.preferredSize = const Size(double.infinity, 30),
    Key key,
  })  : assert(title != null),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ).headline6,
      ),
    );
  }
}
