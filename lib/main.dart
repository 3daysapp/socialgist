import 'package:flutter/material.dart';

import 'Login.dart';

///
///
///
void main() {
  runApp(Socialgist());
}

///
///
///
class Socialgist extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialGist',
      theme: ThemeData.dark().copyWith(
        buttonTheme: ThemeData.dark().buttonTheme.copyWith(
              buttonColor: Colors.tealAccent,
              textTheme: ButtonTextTheme.primary,
            ),
      ),
      home: Login(),
    );
  }
}
