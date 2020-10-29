import 'package:flutter/widgets.dart';
import 'package:socialgist/model/user.dart';
import 'package:socialgist/provider/abstract_list_provider.dart';
import 'package:socialgist/provider/user_provider.dart';

///
///
///
class UserFollowersProvider extends UserProvider
    with AbstractListProvider<User> {
  ///
  ///
  ///
  UserFollowersProvider({
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
  /// https://developer.github.com/v3/users/followers/#list-followers-of-a-user
  ///
  @override
  Future<List<User>> get() {
    return typedList(
      model: User(),
      path: ['followers'],
    );
  }

  ///
  /// https://developer.github.com/v3/users/followers/#list-followers-of-a-user
  ///
  @override
  Future<List<User>> next() {
    return typedNextList(
      model: User(),
      path: ['followers'],
    );
  }
}
