import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/user.dart';
import 'package:socialgist/provider/user_provider.dart';
import 'package:socialgist/widgets/default_scaffold.dart';
import 'package:socialgist/widgets/future_builder_flow.dart';
import 'package:socialgist/widgets/profile_body.dart';

///
///
///
class UserProfile extends StatefulWidget {
  final User user;

  ///
  ///
  ///
  const UserProfile(
    this.user, {
    Key key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _UserProfileState createState() => _UserProfileState();
}

///
///
///
class _UserProfileState extends State<UserProfile> {
  User _user;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      subtitle: 'Profile'.i18n,
      body: Builder(
        builder: (context) {
          if (_user.publicRepos == null || _user.publicGists == null) {
            return FutureBuilderFlow<User>(
              future: UserProvider(context: context, user: _user).getUser(),
              dataBuilder: (context, user) {
                _user = user;
                return ProfileBody(user);
              },
            );
          }

          return ProfileBody(_user);
        },
      ),
    );
  }
}
