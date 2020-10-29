import 'package:flutter/widgets.dart';
import 'package:socialgist/model/gist.dart';
import 'package:socialgist/model/gist_comment.dart';
import 'package:socialgist/provider/abstract_list_provider.dart';
import 'package:socialgist/provider/abstract_provider.dart';

///
///
///
class GistCommentProvider extends AbstractProvider<GistComment>
    with AbstractListProvider<GistComment> {
  ///
  ///
  ///
  GistCommentProvider({
    @required BuildContext context,
    @required Gist gist,
    int page,
    int perPage,
  }) : super(
          context: context,
          endpoint: 'gists/${gist.id}/comments',
          model: GistComment(),
          page: page,
          perPage: perPage,
        );

  ///
  /// https://developer.github.com/v3/gists/comments/#list-comments-on-a-gist
  ///
  @override
  Future<List<GistComment>> get() {
    return getList();
  }

  ///
  /// https://developer.github.com/v3/gists/comments/#list-comments-on-a-gist
  ///
  @override
  Future<List<GistComment>> next() {
    return getNextList();
  }
}
