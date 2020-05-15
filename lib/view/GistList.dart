import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
class GistList extends StatefulWidget {
  final AbstractListProvider provider;
  final ValueNotifier<HomeEvent> homeController;
  final bool defaultStarred;

  ///
  ///
  ///
  const GistList({
    Key key,
    @required this.provider,
    this.homeController,
    @required this.defaultStarred,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _GistListState createState() => _GistListState();
}

///
///
///
class _GistListState extends State<GistList> {
  final SplayTreeMap<String, Gist> _gists =
      SplayTreeMap((i, j) => j.compareTo(i));

  AbstractListProvider _providerHolder;
  ScrollController _scrollController;
  bool _loading = true;
  List<String> _mutedUsers;
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
          if (_gists.length > 100) {
            _scrollController.jumpTo(0.0);
          } else {
            _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: _gists.length * 50),
              curve: Curves.easeInOut,
            );
          }
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
    if (mounted) setState(() => _loading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mutedUsers = prefs.getStringList('mutedUsers') ?? [];

    List<Gist> gists = await _providerHolder.get();
    _gists.clear();
    for (Gist gist in gists) {
      if (!_mutedUsers.contains(gist.owner.login)) {
        _gists[gist.createdAt] = gist;
      }
    }

    if (mounted) _scrollController.jumpTo(0.0);
    if (mounted) setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    if (mounted) setState(() => _loading = true);
    String oldKey = _gists.lastKey();
    String newKey = _gists.lastKey();
    DateTime lastDate = _gists[oldKey].createdAtDate;
    int trying = 15;

    while (oldKey == newKey && trying > 0) {
      List<Gist> gists = await _providerHolder.next();
      for (Gist gist in gists) {
        if (!_mutedUsers.contains(gist.owner.login) &&
            gist.createdAtDate.isBefore(lastDate)) {
          _gists[gist.createdAt] = gist;
        }
      }
      newKey = _gists.lastKey();
      trying--;
    }

    if (trying < 1) await _initialData();

    if (mounted) setState(() => _loading = false);
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
                  itemBuilder: (context, index) {
                    String key = _gists.keys.elementAt(index);
                    return GistCard(
                      gist: _gists[key],
                      defaultStarred: widget.defaultStarred,
                      key: Key(key),
                    );
                  },
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
                          Colors.black26,
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
