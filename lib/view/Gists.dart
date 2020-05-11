import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';
import 'package:socialgist/view/Home.dart';
import 'package:socialgist/widgets/GistCard.dart';

enum GistsType {
  user,
  public,
}

///
///
///
class Gists extends StatefulWidget {
  final ValueNotifier<HomeEvent> homeController;
  final AbstractListProvider provider;

  ///
  ///
  ///
  const Gists({
    Key key,
    @required this.provider,
    this.homeController,
  }) : super(key: key);

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

  AbstractListProvider _providerHolder;
  ScrollController _scrollController;
  bool _loading = true;

  Function _homeListener;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    _providerHolder = widget.provider;

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent -
              (MediaQuery.of(context).size.height * 0.4)) {
        if (!_loading && _providerHolder.hasNext) {
          _nextData();
        }
      }
    });

    if (widget.homeController != null) {
      _homeListener = () {
        if (widget.homeController.value == HomeEvent.gistsTabScrollTop) {
          _scrollController.animateTo(
            0.0,
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
          );
        }
      };

      widget.homeController.addListener(_homeListener);
    }
    _initialData();
  }

  ///
  ///
  ///
  Future<void> _initialData() async {
    setState(() => _loading = true);
    List<Gist> gists = await _providerHolder.get();
    _gists.clear();
    _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    setState(() => _loading = true);
    List<Gist> gists = await _providerHolder.next();
    _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _initialData,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemBuilder: (context, index) =>
                      GistCard(_gists[_gists.keys.elementAt(index)]),
                  itemCount: _gists.length,
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  bottom: _loading ? 0 : -60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black38,
                          Colors.black87,
                        ],
                      ),
                    ),
                    height: 60.0,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text('Loading...'.i18n),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    if (widget.homeController != null) {
      widget.homeController.removeListener(_homeListener);
    }
    _scrollController.dispose();
    super.dispose();
  }
}
