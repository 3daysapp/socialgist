import '../model/User.dart';

import 'AbstractProvider.dart';

///
///
///
class AuthUserProvider extends AbstractProvider<User> {
  ///
  ///
  ///
  AuthUserProvider()
      : super(
          endpoint: 'user',
          model: User(),
        );
}
