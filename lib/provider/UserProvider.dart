import 'package:flutter/widgets.dart';

import '../model/User.dart';

import 'AbstractProvider.dart';

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
}
