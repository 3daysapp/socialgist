import 'package:flutter/material.dart';

///
///
///
class WaitingMessage extends StatelessWidget {
  final String message;

  ///
  ///
  ///
  const WaitingMessage(
    this.message, {
    Key key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircularProgressIndicator(),
        ),
        Center(
          child: Text(message),
        ),
      ],
    );
  }
}
