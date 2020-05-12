import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';
import 'package:socialgist/view/GistList.dart';
import 'package:socialgist/widgets/DefaultScaffold.dart';

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
      body: GistList(provider: provider),
    );
  }
}
