import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:socialgist/main.dart';
import 'package:socialgist/util/Config.dart';

import 'secret.dart';

///
///
///
void main() {
  Config _config = Config();

  _config.debug = true;

  _config.test = true;
  _config.testMessage = secret;

  enableFlutterDriverExtension(handler: (String msg) async {
    print('Test handler: $msg');
    return msg;
  });

  WidgetsApp.debugAllowBannerOverride = false;

  runApp(Socialgist());
}
