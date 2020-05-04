import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class CardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData iconData;
  final double height;

  ///
  ///
  ///
  const CardButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    @required this.iconData,
    this.height = 40.0,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FittedBox(
        child: FlatButton.icon(
          onPressed: onPressed,
          icon: FaIcon(iconData),
          label: Text(label),
        ),
      ),
    );
  }
}
