import 'package:flutter/widgets.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AbstractProvider.dart';

enum UserList {
  following,
  followers,
}

extension UserListExt on UserList {
  String get value => toString().split('.').last;
}

///
///
///
class UserProvider extends AbstractProvider<User> {
  ///
  ///
  ///
  UserProvider(BuildContext context)
      : super(
          context: context,
          endpoint: 'users',
          model: User(),
        );

  ///
  ///
  ///
  Future<List<User>> getUserList(User user, UserList type) {
    return getList([user.login, type.value]);
  }

  ///
  ///
  ///
  Future<List<User>> getUserNextList(User user, UserList type) {
    return getNextList([user.login, type.value]);
  }

  ///
  ///
  ///
  Future<User> getUser(User user) {
    return getObject([user.login]);
  }
}
