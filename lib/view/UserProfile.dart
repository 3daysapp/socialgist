import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/UserProvider.dart';
import 'package:socialgist/util/ColumnMessage.dart';
import 'package:socialgist/util/WaitingMessage.dart';
import 'package:socialgist/widgets/DefaultScaffold.dart';
import 'package:socialgist/widgets/ProfileBody.dart';

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
            return FutureBuilder<User>(
              future: UserProvider(context: context, user: _user).getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _user = snapshot.data;
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

          return ProfileBody(_user);
        },
      ),
    );
  }
}
