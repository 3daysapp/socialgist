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
}
