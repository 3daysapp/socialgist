import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/user.dart';
import 'package:socialgist/provider/abstract_list_provider.dart';
import 'package:socialgist/provider/user_provider.dart';
import 'package:socialgist/util/column_message.dart';
import 'package:socialgist/util/waiting_message.dart';
import 'package:socialgist/widgets/default_scaffold.dart';
import 'package:socialgist/widgets/user_tile.dart';

///
///
///
class FollowList extends StatefulWidget {
  final String title;
  final AbstractListProvider provider;

  ///
  ///
  ///
  const FollowList({
    Key key,
    @required this.title,
    @required this.provider,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _FollowListState createState() => _FollowListState();
}

///
///
///
class _FollowListState extends State<FollowList> {
  final List<String> _cacheHit = [];
  List<User> _users;
  ScrollController _scrollController;
  AbstractListProvider _providerHolder;
  bool _loading = true;

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

    _loadData();
  }

  ///
  ///
  ///
  void _loadData() async {
    if (mounted) setState(() => _loading = true);
    _users = [];
    List<User> users = await _providerHolder.get();
    _users.addAll(users);
    if (mounted) setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    if (mounted) setState(() => _loading = true);
    List<User> users = await _providerHolder.next();
    _users.addAll(users);
    if (mounted) setState(() => _loading = false);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      subtitle: widget.title,
      body: Builder(builder: (context) {
        if (_users == null) {
          return WaitingMessage('Loading...'.i18n);
        }

        if (_users.isEmpty) {
          return ColumnMessage(
            message: 'Nobody around here.'.i18n,
          );
        }

        return Stack(
          children: <Widget>[
            ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                User user = _users[index];

                if (_cacheHit.contains(user.login)) {
                  return UserTile(user);
                }

                return FutureBuilder(
                  future: UserProvider(
                    context: context,
                    user: user,
                  ).getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User u = snapshot.data;
                      _users[index] = u;
                      _cacheHit.add(user.login);
                      return UserTile(u);
                    }

                    return ListTile(
                      title: Text('Loading...'.i18n),
                      subtitle: Text(user.login),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: _users.length,
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
        );
      }),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
