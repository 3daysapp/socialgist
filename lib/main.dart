import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:socialgist/Login.dart';
import 'package:socialgist/util/Config.dart';

///
///
///
void main() {
  bool debug = false;

  assert(debug = true);

  Config _config = Config();

  _config.debug = debug;

  if (kIsWeb) {
    _config.platform = Config.WEB;
  }

  runApp(Socialgist());
}

///
///
///
class Socialgist extends StatelessWidget {
  final String message;
  final bool authAgain;

  ///
  ///
  ///
  const Socialgist({
    Key key,
    this.message,
    this.authAgain = false,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialGist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        buttonTheme: ThemeData.dark().buttonTheme.copyWith(
              buttonColor: Colors.tealAccent,
              textTheme: ButtonTextTheme.primary,
            ),
      ),
      home: Login(
        message: message,
        authAgain: authAgain,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
    );
  }
}
