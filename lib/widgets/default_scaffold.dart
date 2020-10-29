import 'package:flutter/material.dart';
import 'package:socialgist/widgets/home_button.dart';
import 'package:socialgist/widgets/scaffold_bottom_title.dart';
import 'package:socialgist/widgets/social_gist_logo.dart';

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
