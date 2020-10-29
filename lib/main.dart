import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:socialgist/Login.dart';
import 'package:socialgist/util/Config.dart';

///
///
///
void main() async {
  bool debug = false;
  assert(debug = true);
  Config _config = Config();
  _config.debug = debug;

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    _config.platform = Config.WEB;
  }

  await Firebase.initializeApp();

  if (debug) {
    runApp(SocialGist());
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runZonedGuarded(
          () => runApp(SocialGist()),
      FirebaseCrashlytics.instance.recordError,
    );
  }
}

///
///
///
class SocialGist extends StatelessWidget {
  final String message;
  final bool authAgain;

  ///
  ///
  ///
  const SocialGist({
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
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
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
