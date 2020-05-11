import 'package:flutter/widgets.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AbstractProvider.dart';

///
///
///
class UserProvider extends AbstractProvider<User> {
  final User user;

  ///
  ///
  ///
  UserProvider({
    @required BuildContext context,
    @required this.user,
    int page,
    int perPage,
  }) : super(
          context: context,
          endpoint: 'users',
          model: User(),
          page: page,
          perPage: perPage,
        );

  ///
  /// https://developer.github.com/v3/users/#get-a-single-user
  ///
  Future<User> getUser() {
    return getObject(path: [user.login]);
  }
}
