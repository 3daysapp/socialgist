import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/UserProvider.dart';
import 'package:socialgist/util/WaitingMessage.dart';
import 'package:socialgist/view/UserProfile.dart';
import 'package:socialgist/widgets/DefaultScaffold.dart';

///
///
///
class FollowList extends StatefulWidget {
  final String title;
  final UserList userList;
  final User user;

  ///
  ///
  ///
  const FollowList({
    Key key,
    @required this.title,
    @required this.userList,
    @required this.user,
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
  final List<User> _users = [];
  final List<String> _cacheHit = [];
  ScrollController _scrollController;
  UserProvider _provider;
  bool _loading = true;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

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

    _provider = UserProvider(context);
    _loadData();
  }

  ///
  ///
  ///
  void _loadData() async {
    setState(() => _loading = true);
    List<User> users = await _provider.getUserList(
      widget.user,
      widget.userList,
    );
    _users.addAll(users);
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    setState(() => _loading = true);
    List<User> users = await _provider.getUserNextList(
      widget.user,
      widget.userList,
    );
    _users.addAll(users);
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      subtitle: widget.title,
      body: Builder(builder: (context) {
        if (_users.isEmpty) {
          return WaitingMessage('Loading...'.i18n);
        }

        return Stack(
          children: <Widget>[
            ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                User user = _users[index];

                if (_cacheHit.contains(user.login)) {
                  return _getUserTile(user);
                }

                return FutureBuilder(
                  future: UserProvider(context).getUser(user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User u = snapshot.data;
                      _users[index] = u;
                      _cacheHit.add(user.login);
                      return _getUserTile(u);
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
  Widget _getUserTile(User user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black54,
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
      title: Text(user.name ?? user.login),
      subtitle: Text(
        _getFirstNotEmpty(
          [
            user.location,
            user.email,
            user.blog,
            user.company,
            user.bio,
            user.login
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserProfile(user),
        ),
      ),
    );
  }

  ///
  ///
  ///
  String _getFirstNotEmpty(List<String> strings) {
    for (String s in strings) {
      if (s != null && s.isNotEmpty) {
        return s;
      }
    }
    return '???';
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
