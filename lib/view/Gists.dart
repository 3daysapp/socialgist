import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';
import 'package:socialgist/widgets/GistCard.dart';

///
///
///
class Gists extends StatefulWidget {
  ///
  ///
  ///
  @override
  _GistsState createState() => _GistsState();
}

///
///
///
class _GistsState extends State<Gists> {
  final SplayTreeMap<String, Gist> _gists =
      SplayTreeMap((i, j) => j.compareTo(i));

  PublicGistProvider _provider;
  ScrollController _scrollController;
  bool _loading = true;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _provider = PublicGistProvider(context, perPage: 8);
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent -
              (MediaQuery.of(context).size.height * 0.4)) {
        if (!_loading && _provider.hasNext) {
          _nextData();
        }
      }
    });

    _initialData();
  }

  ///
  ///
  ///
  Future<void> _initialData() async {
    setState(() => _loading = true);
    List<Gist> gists = await _provider.getList(['public']);
    _gists.clear();
    _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    setState(() => _loading = true);
    List<Gist> gists = await _provider.getNextList(['public']);
    _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RefreshIndicator(
        onRefresh: () async {
          List<Gist> gists = await _provider.getList(['public']);
          _gists.clear();
          _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
          setState(() => _loading = false);
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    children:
                        _gists.values.map((gist) => GistCard(gist)).toList(),
                  ),
                  Positioned(
                    bottom: 0.0,
                    // TODO - Change Visibility to Animation.
                    child: Visibility(
                      visible: _loading,
                      child: Container(
                        color: Colors.black87,
                        height: 60.0,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
