import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/view/Gists.dart';
import 'package:socialgist/view/Profile.dart';
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
      length: 2,
    );
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SocialGistLogo(),
        bottom: TabBar(
          controller: _tabController,
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
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.solidCompass),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Explorar'),
                  )
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.solidUserCircle),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Perfil'),
                  )
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Gists(
            homeController: _homeController,
          ),
          Profile(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          child: StreamBuilder<double>(
              initialData: 0,
              stream: Stream.periodic(
                Duration(seconds: 5),
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
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
