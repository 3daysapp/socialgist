import 'package:flutter/widgets.dart';

import '../model/User.dart';

import 'AbstractProvider.dart';

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
}
