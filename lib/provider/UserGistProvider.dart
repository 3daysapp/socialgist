import 'package:flutter/widgets.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';
import 'package:socialgist/provider/UserProvider.dart';

///
///
///
class UserGistProvider extends UserProvider with AbstractListProvider<Gist> {
  ///
  ///
  ///
  UserGistProvider({
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
  /// https://developer.github.com/v3/gists/#list-gists-for-a-user
  ///
  @override
  Future<List<Gist>> get() {
    return typedList(
      model: Gist(),
      path: ['gists'],
    );
  }

  ///
  /// https://developer.github.com/v3/gists/#list-gists-for-a-user
  ///
  @override
  Future<List<Gist>> next() {
    return typedNextList(
      model: Gist(),
      path: ['gists'],
    );
  }
}
