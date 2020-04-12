import '../model/Gist.dart';

import 'AbstractProvider.dart';

///
///
///
class PublicGistProvider extends AbstractProvider<Gist> {
  ///
  ///
  ///
  PublicGistProvider({
    int page,
    int perPage,
  }) : super(
          endpoint: 'gists',
          model: Gist(),
          page: page,
          perPage: perPage,
        );
}
