import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/util/WaitingMessage.dart';

import '../widgets/SocialGistLogo.dart';

///
///
///
class Home extends StatefulWidget {
  ///
  ///
  ///
  @override
  _HomeState createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  final StreamController<User> _controller = StreamController();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///
  ///
  ///
  void _loadData() async {
    AuthUserProvider provider = AuthUserProvider();

    User me = await provider.getObject();

    _controller.add(me);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SocialGistLogo(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: StreamBuilder<User>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User me = snapshot.data;

            List<Widget> widgets = [];

            if (me.avatarUrl != null && me.avatarUrl.isNotEmpty) {
              widgets.add(
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    backgroundImage: NetworkImage(me.avatarUrl),
                    minRadius: 30.0,
                    maxRadius: 80.0,
                  ),
                ),
              );
            }

            widgets.add(Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                me.name ?? me.login,
                style: Theme.of(context).textTheme.headline5,
              ),
            ));

            if (me.company != null && me.company.isNotEmpty) {
              widgets.add(Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  me.company,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ));
            }

            if (me.email != null && me.email.isNotEmpty) {
              widgets.add(Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  me.email,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ));
            }

            if (me.location != null && me.location.isNotEmpty) {
              widgets.add(Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  me.location,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ));
            }

            if (me.blog != null && me.blog.isNotEmpty) {
              widgets.add(Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  me.blog,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ));
            }

            Map<String, int> cards = {
              'Seguindo': me.following ?? 0,
              'Seguidores': me.followers ?? 0,
              'Repositórios':
                  (me.publicRepos ?? 0) + (me.totalPrivateRepos ?? 0),
              'Gists': (me.publicGists ?? 0) + (me.privateGists ?? 0),
            };

            widgets.add(
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: cards.keys
                      .map(
                        (key) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Spacer(),
                                Text(
                                  '${cards[key]}',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Spacer(),
                                Text(
                                  key,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            );

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widgets,
              ),
            );
          }

          // TODO - Tratamento de erros.

          return WaitingMessage('Aguarde...');
        },
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
