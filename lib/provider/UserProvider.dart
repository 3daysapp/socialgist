import 'package:flutter/widgets.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AbstractProvider.dart';

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
