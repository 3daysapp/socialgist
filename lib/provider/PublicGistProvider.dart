import 'package:flutter/widgets.dart';

import '../model/Gist.dart';

import 'AbstractProvider.dart';

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
