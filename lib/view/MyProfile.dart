import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/util/ColumnMessage.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/util/WaitingMessage.dart';
import 'package:socialgist/widgets/ProfileBody.dart';

///
///
///
class MyProfile extends StatefulWidget {
  ///
  ///
  ///
  @override
  _MyProfileState createState() => _MyProfileState();
}

///
///
///
class _MyProfileState extends State<MyProfile> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: AuthUserProvider(context: context).me(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User me = snapshot.data;
          Config().me = me;
          return ProfileBody(me);
        }

        if (snapshot.hasError) {
          return ColumnMessage(
            errorMessage: snapshot.error,
          );
        }

        return WaitingMessage('Loading...'.i18n);
      },
    );
  }
}
