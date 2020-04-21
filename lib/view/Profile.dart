import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialgist/model/User.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/util/WaitingMessage.dart';

///
///
///
class Profile extends StatefulWidget {
  ///
  ///
  ///
  @override
  _ProfileState createState() => _ProfileState();
}

///
///
///
class _ProfileState extends State<Profile> {
  StreamController<User> _controller;

  // Example of a color with opacity shared in some places
  Color softWhite = Colors.white.withOpacity(0.5);

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _controller = StreamController();
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
    return StreamBuilder<User>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User me = snapshot.data;

          List<Widget> rowAvatarWidgets = [];
          List<Widget> profileInfoWidgets = [];

          if (hasInfo(me.company)) {
            rowAvatarWidgets.add(
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.business,
                      color: softWhite,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      me.company,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            );
          }

          if (hasInfo(me.avatarUrl)) {
            // CircleAvatar as a parent with a larger size and background color to create a border effect
            rowAvatarWidgets.add(
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  minRadius: 22.0,
                  maxRadius: 52.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    backgroundImage: NetworkImage(me.avatarUrl),
                    minRadius: 20.0,
                    maxRadius: 50.0,
                  ),
                ),
              ),
            );
          }

          if (hasInfo(me.location)) {
            rowAvatarWidgets.add(
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: softWhite,
                    ),
                    SizedBox(height: 5),
                    Text(
                      me.location,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            );
          }

          profileInfoWidgets.add(
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 15.0),
              child: Row(
                children: rowAvatarWidgets,
              ),
            ),
          );

          profileInfoWidgets.add(
            Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Text(
                me.name ?? me.login,
                style: GoogleFonts.openSans(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: softWhite,
                ),
              ),
            ),
          );

          if (hasInfo(me.email)) {
            profileInfoWidgets.add(Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                me.email,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ));
          }

          profileInfoWidgets.add(
            Container(
              width: 50,
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Divider(
                height: 1,
                color: Theme.of(context).accentColor,
                thickness: 1,
              ),
            ),
          );

          if (hasInfo(me.blog)) {
            profileInfoWidgets.add(
              Text(
                me.blog,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            );
          }

          Map<String, int> cards = {
            'Seguindo': me.following ?? 0,
            'Seguidores': me.followers ?? 0,
            'Repositórios': (me.publicRepos ?? 0) + (me.totalPrivateRepos ?? 0),
            'Gists': (me.publicGists ?? 0) + (me.privateGists ?? 0),
          };

          profileInfoWidgets.add(
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                children: cards.keys
                    .map(
                      (key) => Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${cards[key]}',
                              style: TextStyle(
                                fontSize: 50.0,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                              key,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
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
              children: profileInfoWidgets,
            ),
          );
        }

        // TODO - Tratamento de erros.

        return WaitingMessage('Aguarde...');
      },
    );
  }

  bool hasInfo(String info) {
    return info != null && info.isNotEmpty;
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
