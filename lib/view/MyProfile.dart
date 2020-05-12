import 'package:flutter/material.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/widgets/FutureBuilderFlow.dart';
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
    return FutureBuilderFlow<User>(
      future: AuthUserProvider(context: context).me(),
      dataBuilder: (context, user) {
        Config().me = user;
        return ProfileBody(user);
      },
    );
  }
}
