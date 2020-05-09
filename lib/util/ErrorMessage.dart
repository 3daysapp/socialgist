import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';

///
///
///
class ErrorMessage extends StatelessWidget {
  final String message;
  final List<Widget> extras;

  ///
  ///
  ///
  const ErrorMessage(
    this.message, {
    Key key,
    this.extras,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Error'.i18n,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(message.toString()),
          if (extras != null) ...extras,
        ],
      ),
    );
  }
}
