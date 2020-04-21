import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Login.dart';
import 'util/Config.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
    );
  }
}
