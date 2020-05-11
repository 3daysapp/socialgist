import 'package:flutter/widgets.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AbstractProvider.dart';

///
///
///
class AuthUserProvider extends AbstractProvider<User> {
  ///
  ///
  ///
  AuthUserProvider(BuildContext context)
      : super(
          context: context,
          endpoint: 'user',
          model: User(),
        );

  ///
  ///
  ///
  Future<User> me() {
    return getObject();
  }

  ///
  ///
  ///
  Future<bool> amIFollowing(User user) {
    return check(['following', user.login]);
  }

  ///
  ///
  ///
  Future<bool> unfollow(User user) {
    return delete(['following', user.login]);
  }

  ///
  ///
  ///
  Future<bool> follow(User user) {
    return put(['following', user.login]);
  }
}
