import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/provider/abstract_list_provider.dart';
import 'package:socialgist/view/gist_list.dart';
import 'package:socialgist/widgets/default_scaffold.dart';

///
///
///
class UserGist extends StatelessWidget {
  final AbstractListProvider provider;

  ///
  ///
  ///
  const UserGist({
    Key key,
    this.provider,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      subtitle: 'Gists'.i18n,
      body: GistList(
        provider: provider,
        defaultStarred: false,
      ),
    );
  }
}
