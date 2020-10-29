import 'package:flutter/material.dart';
import 'package:socialgist/model/user.dart';
import 'package:socialgist/provider/auth_user_provider.dart';
import 'package:socialgist/util/config.dart';
import 'package:socialgist/widgets/future_builder_flow.dart';
import 'package:socialgist/widgets/profile_body.dart';

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
