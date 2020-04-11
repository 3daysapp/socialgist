import 'package:flutter/material.dart';
import 'package:socialgist/util/Config.dart';

import '../widgets/SocialGistLogo.dart';

///
///
///
class Home extends StatefulWidget {
  ///
  ///
  ///
  @override
  _HomeState createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SocialGistLogo(),
      ),
      body: Center(
        child: Text(
          'Home!\n\n${Config().token}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
