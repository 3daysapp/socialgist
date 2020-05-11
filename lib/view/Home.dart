import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialgist/Login.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/provider/AuthUserProvider.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';
import 'package:socialgist/provider/StarredGistProvider.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/view/Gists.dart';
import 'package:socialgist/view/MyProfile.dart';
import 'package:socialgist/widgets/SocialGistLogo.dart';

///
///
///
enum HomeEvent {
  none,
  gistsTabScrollTop,
}

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
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ValueNotifier<HomeEvent> _homeController;
  TabController _tabController;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _homeController = ValueNotifier(HomeEvent.none);
    _tabController = TabController(
      vsync: this,
      length: 3,
    );

    AuthUserProvider(context: context).me().then((value) {
      Config().me = value;
    });
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SocialGistLogo(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            key: Key('exitBtn'),
            tooltip: 'Exit'.i18n,
            icon: FaIcon(
              FontAwesomeIcons.signOutAlt,
              semanticLabel: 'Exit'.i18n,
            ),
            onPressed: _logOut,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          onTap: (index) async {
            if (index == 0 && _tabController.index == index) {
              _homeController.value = HomeEvent.gistsTabScrollTop;
              await Future.delayed(
                Duration(milliseconds: 2000),
                () => _homeController.value = HomeEvent.none,
              );
            }
          },
          tabs: [
            /// Explore
            Tab(
              key: Key('exploreTab'),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.solidCompass,
                    semanticLabel: 'Explore'.i18n,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Explore'.i18n),
                  )
                ],
              ),
            ),

            /// Star
            Tab(
              key: Key('starredGistsTab'),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    semanticLabel: 'Starred Gists'.i18n,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Starred Gists'.i18n),
                  )
                ],
              ),
            ),

            /// Profile
            Tab(
              key: Key('profileTab'),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.solidUserCircle,
                    semanticLabel: 'Profile'.i18n,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Profile'.i18n),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Gists(
            provider: PublicGistProvider(
              context: context,
              perPage: 8,
            ),
            homeController: _homeController,
          ),
          Gists(
            provider: StarredGistProvider(
              context: context,
            ),
            homeController: _homeController,
          ),
          MyProfile(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          child: StreamBuilder<double>(
              initialData: 0,
              stream: Stream.periodic(
                Duration(seconds: 10),
                (i) => Config().apiUsage.percent,
              ),
              builder: (context, snapshot) {
                return LinearProgressIndicator(
                  value: snapshot.data,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                );
              }),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
      (_) => false,
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
