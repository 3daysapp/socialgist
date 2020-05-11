import 'package:flutter/widgets.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';
import 'package:socialgist/provider/UserProvider.dart';

///
///
///
class UserFollowingProvider extends UserProvider
    with AbstractListProvider<User> {
  ///
  ///
  ///
  UserFollowingProvider({
    @required BuildContext context,
    @required User user,
    int page,
    int perPage,
  }) : super(
          context: context,
          user: user,
          page: page,
          perPage: perPage,
        );

  ///
  /// https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  ///
  @override
  Future<List<User>> get() {
    return typedList(
      model: User(),
      path: [user.login, 'following'],
    );
  }

  ///
  /// https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  ///
  @override
  Future<List<User>> next() {
    return typedNextList(
      model: User(),
      path: [user.login, 'following'],
    );
  }
}
