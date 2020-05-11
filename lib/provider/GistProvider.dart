import 'package:flutter/widgets.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/AbstractProvider.dart';

///
///
///
class GistProvider extends AbstractProvider<Gist> {
  ///
  ///
  ///
  GistProvider(
    BuildContext context, {
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
  ///
  ///
  Future<Gist> getById(String id) {
    return getObject([id]);
  }

  ///
  ///
  ///
  Future<bool> amIStarred(Gist gist) {
    return check([gist.id, 'star']);
  }

  ///
  ///
  ///
  Future<bool> unstar(Gist gist) {
    return delete([gist.id, 'star']);
  }

  ///
  ///
  ///
  Future<bool> star(Gist gist) {
    return put([gist.id, 'star']);
  }

  ///
  ///
  ///
  Future<List<Gist>> public() {
    return getList(['public']);
  }

  ///
  ///
  ///
  Future<List<Gist>> publicNext() {
    return getNextList(['public']);
  }
}
