import 'package:flutter/widgets.dart';
import 'package:socialgist/model/gist.dart';
import 'package:socialgist/provider/abstract_provider.dart';
import 'package:socialgist/provider/abstract_list_provider.dart';

///
///
///
class PublicGistProvider extends AbstractProvider<Gist>
    with AbstractListProvider<Gist> {
  ///
  ///
  ///
  PublicGistProvider({
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
  /// https://developer.github.com/v3/gists/#list-public-gists
  ///
  @override
  Future<List<Gist>> get() {
    return getList(path: ['public']);
  }

  ///
  /// https://developer.github.com/v3/gists/#list-public-gists
  ///
  @override
  Future<List<Gist>> next() {
    return getNextList(path: ['public']);
  }
}
