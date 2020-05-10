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
  Future<bool> amIFollowing(User user) {
    return check(['following', user.login]);
  }

  ///
  ///
  ///
  Future<bool> unfollow(User user) {
    return deleteEmpty(['following', user.login]);
  }

  ///
  ///
  ///
  Future<bool> follow(User user) {
    return putEmpty(['following', user.login]);
  }
}
