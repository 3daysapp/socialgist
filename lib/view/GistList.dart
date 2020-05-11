import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';
import 'package:socialgist/view/Gists.dart';
import 'package:socialgist/widgets/DefaultScaffold.dart';

///
///
///
class GistList extends StatelessWidget {
  final AbstractListProvider provider;

  ///
  ///
  ///
  const GistList({
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
      body: Gists(provider: provider),
    );
  }
}
