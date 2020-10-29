import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';

///
///
///
class ColumnMessage extends StatelessWidget {
  final String message;
  final String errorMessage;
  final List<Widget> extras;

  ///
  ///
  ///
  const ColumnMessage({
    Key key,
    this.message,
    this.errorMessage,
    this.extras,
  })  : assert(message != null || errorMessage != null),
        super(key: key);

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
          if (errorMessage != null)
            Text(
              'Error'.i18n,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          Text(
            (errorMessage ?? message).toString(),
            textAlign: TextAlign.center,
          ),
          ...?extras,
        ],
      ),
    );
  }
}
