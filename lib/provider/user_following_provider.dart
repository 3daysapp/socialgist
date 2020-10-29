import 'package:flutter/widgets.dart';
import 'package:socialgist/model/user.dart';
import 'package:socialgist/provider/abstract_list_provider.dart';
import 'package:socialgist/provider/user_provider.dart';

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
      path: ['following'],
    );
  }

  ///
  /// https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
  ///
  @override
  Future<List<User>> next() {
    return typedNextList(
      model: User(),
      path: ['following'],
    );
  }
}
