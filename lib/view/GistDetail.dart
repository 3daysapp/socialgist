import 'package:flutter/material.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/view/UserProfile.dart';
import 'package:socialgist/widgets/DefaultScaffold.dart';
import 'package:socialgist/widgets/GistButtonBar.dart';
import 'package:socialgist/widgets/DateFormatted.dart';
import 'package:socialgist/widgets/GistFile.dart';
import 'package:socialgist/widgets/GistHeader.dart';

///
///
///
class GistDetail extends StatefulWidget {
  final Gist gist;
  final bool defaultStarred;

  ///
  ///
  ///
  const GistDetail({
    this.gist,
    this.defaultStarred,
    Key key,
  }) : super(key: key);

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
    return DefaultScaffold(
      subtitle: 'Gist'.i18n,
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GistHeader(
                widget.gist,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserProfile(widget.gist.owner),
                  ),
                ),
              ),
              GistButtonBar(
                gist: widget.gist,
                controller: _controller,
                defaultStarred: widget.defaultStarred,
              ),
              ...widget.gist.files.map(
                (file) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GistFile(file, _controller),
                ),
              ),
//              if (widget.gist.truncated) Text('Truncado.'),
              DateFormatted(widget.gist.createdAtDate.toLocal()),
              Container(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
