import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/util/ColumnMessage.dart';
import 'package:socialgist/util/WaitingMessage.dart';
import 'package:socialgist/widgets/ProfileBody.dart';

/*
My Gists ??

https://gist.github.com/edufolly/starred

r'<a class="link-overlay" href="https://gist.github.com/(?<user>.*)/(?<gist>.*)">'
 */

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
    return StreamBuilder<User>(
      stream: AuthUserProvider(context).getObject().asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProfileBody(snapshot.data);
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
