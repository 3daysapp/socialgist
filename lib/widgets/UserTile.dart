import 'package:flutter/material.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/view/UserProfile.dart';

class UserTile extends StatelessWidget {
  final User user;

  ///
  ///
  ///
  const UserTile(
    this.user, {
    Key key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black54,
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
      title: Text(user.name ?? user.login),
      subtitle: Text(
        _getFirstNotEmpty(
          [
            user.location,
            user.email,
            user.blog,
            user.company,
            user.bio,
            user.login
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserProfile(user),
        ),
      ),
    );
  }

  ///
  ///
  ///
  String _getFirstNotEmpty(List<String> strings) {
    for (String s in strings) {
      if (s != null && s.isNotEmpty) {
        return s;
      }
    }
    return '???';
  }
}
