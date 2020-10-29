import 'package:flutter/widgets.dart';
import 'package:socialgist/model/user.dart';
import 'package:socialgist/provider/abstract_provider.dart';

///
/// Authenticated User
///
class AuthUserProvider extends AbstractProvider<User> {
  ///
  ///
  ///
  AuthUserProvider({
    @required BuildContext context,
  }) : super(
          context: context,
          endpoint: 'user',
          model: User(),
        );

  ///
  /// https://developer.github.com/v3/users/#get-the-authenticated-user
  ///
  /// Authenticated User
  Future<User> me() {
    return getObject();
  }

  ///
  /// https://developer.github.com/v3/users/followers/#check-if-you-are-following-a-user
  ///
  /// Authenticated User
  Future<bool> amIFollowing(User user) {
    return check(path: ['following', user.login]);
  }

  ///
  /// https://developer.github.com/v3/users/followers/#unfollow-a-user
  ///
  /// Authenticated User
  Future<bool> unfollow(User user) {
    return delete(path: ['following', user.login]);
  }

  ///
  /// https://developer.github.com/v3/users/followers/#follow-a-user
  ///
  /// Authenticated User
  Future<bool> follow(User user) {
    return put(path: ['following', user.login]);
  }
}
