import 'package:flutter/material.dart';
import 'package:socialgist/widgets/HomeButton.dart';
import 'package:socialgist/widgets/ScaffoldBottomTitle.dart';
import 'package:socialgist/widgets/SocialGistLogo.dart';

///
///
///
class DefaultScaffold extends StatelessWidget {
  final String subtitle;
  final Widget body;
  final Color backgroundColor;

  ///
  ///
  ///
  const DefaultScaffold({
    Key key,
    @required this.subtitle,
    @required this.body,
    this.backgroundColor,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SocialGistLogo(),
        centerTitle: true,
        actions: <Widget>[
          HomeButton(),
        ],
        bottom: ScaffoldBottomTitle(subtitle),
      ),
      backgroundColor: backgroundColor,
      body: body,
    );
  }
}
