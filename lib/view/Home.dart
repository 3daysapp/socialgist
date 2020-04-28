import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/util/Config.dart';

import '../view/Profile.dart';
import '../widgets/SocialGistLogo.dart';
import 'Gists.dart';

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
  TabController _tabController;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
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
          Gists(),
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
}
