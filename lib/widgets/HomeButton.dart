import 'package:flutter/material.dart';
import 'package:socialgist/view/Home.dart';

///
///
///
class HomeButton extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('homeButton'),
      icon: Icon(
        Icons.home,
      ),
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
        (_) => false,
      ),
    );
  }
}
