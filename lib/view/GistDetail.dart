import 'package:flutter/material.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/widgets/GistButtonBar.dart';
import 'package:socialgist/widgets/GistDate.dart';
import 'package:socialgist/widgets/GistFile.dart';
import 'package:socialgist/widgets/GistHeader.dart';
import 'package:socialgist/widgets/SocialGistLogo.dart';

///
///
///
class GistDetail extends StatefulWidget {
  final Gist gist;

  ///
  ///
  ///
  const GistDetail(this.gist, {Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _GistDetailState createState() => _GistDetailState();
}

///
///
///
class _GistDetailState extends State<GistDetail> with TickerProviderStateMixin {
  AnimationController _controller;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

//    debugPrint(
//      'Gist Detail: ${widget.gist.toJson()}',
//      wrapWidth: 120,
//    );

    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
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
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GistHeader(widget.gist),
              GistButtonBar(widget.gist, _controller),
              ...widget.gist.files.map(
                (file) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GistFile(file, _controller),
                ),
              ),
//              if (widget.gist.truncated) Text('Truncado.'),
              GistDate(widget.gist),
            ],
          ),
        ),
      ),
    );
  }
}
