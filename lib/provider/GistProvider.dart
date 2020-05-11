import 'package:flutter/widgets.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/AbstractProvider.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';

///
///
///
class GistProvider extends AbstractProvider<Gist>
    with AbstractListProvider<Gist> {
  ///
  ///
  ///
  GistProvider({
    @required BuildContext context,
    int page,
    int perPage,
  }) : super(
          context: context,
          endpoint: 'gists',
          model: Gist(),
          page: page,
          perPage: perPage,
        );

  ///
  /// https://developer.github.com/v3/gists/#get-a-gist
  ///
  Future<Gist> getById(String id) {
    return getObject(path: [id]);
  }

  ///
  /// https://developer.github.com/v3/gists/#check-if-a-gist-is-starred
  ///
  /// Authenticated User
  Future<bool> amIStarred(Gist gist) {
    return check(path: [gist.id, 'star']);
  }

  ///
  /// https://developer.github.com/v3/gists/#unstar-a-gist
  ///
  /// Authenticated User
  Future<bool> unstar(Gist gist) {
    return delete(path: [gist.id, 'star']);
  }

  ///
  /// https://developer.github.com/v3/gists/#star-a-gist
  ///
  /// Authenticated User
  Future<bool> star(Gist gist) {
    return put(path: [gist.id, 'star']);
  }

  ///
  /// https://developer.github.com/v3/gists/#list-gists-for-the-authenticated-user
  ///
  /// Authenticated User
  @override
  Future<List<Gist>> get() {
    return getList();
  }

  ///
  /// https://developer.github.com/v3/gists/#list-gists-for-the-authenticated-user
  ///
  /// Authenticated User
  @override
  Future<List<Gist>> next() {
    return getNextList();
  }
}
