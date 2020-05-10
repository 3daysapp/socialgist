import 'package:flutter/widgets.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/AbstractProvider.dart';

///
///
///
class PublicGistProvider extends AbstractProvider<Gist> {
  ///
  ///
  ///
  PublicGistProvider(
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
}
