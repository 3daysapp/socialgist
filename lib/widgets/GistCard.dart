import 'package:flutter/material.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';
import 'package:socialgist/view/GistDetail.dart';

import 'GistButtonBar.dart';
import 'GistDate.dart';
import 'GistFile.dart';
import 'GistHeader.dart';

///
///
///
class GistCard extends StatefulWidget {
  final Gist gist;

  ///
  ///
  ///
  const GistCard(this.gist, {Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _GistCardState createState() => _GistCardState();
}

///
///
///
class _GistCardState extends State<GistCard> with TickerProviderStateMixin {
  final double fileHeight = 150.0;
  DateTime createdAt;
  AnimationController _controller;
  Gist localGist;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    createdAt = widget.gist.createdAtDate;
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: Column(
                children: <Widget>[
                  /// Header
                  GistHeader(widget.gist),

                  /// First File
                  _getGistFile(),

                  /// Created At
                  GistDate(widget.gist),
                ],
              ),
              onTap: () {
                if (localGist != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GistDetail(localGist),
                    ),
                  );
                }
              },
            ),
            GistButtonBar(widget.gist, _controller),
          ],
        ),
      ),
    );
  }

  ///
  ///
  ///
  Widget _getGistFile() {
    return FutureBuilder<Gist>(
      future: PublicGistProvider(context).getObject([widget.gist.id]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          localGist = snapshot.data;

          if (localGist.files == null || localGist.files.isEmpty) {
            return Center(child: Text('Arquivo não encontrado!'));
          }

          File file = localGist.files.first;

          return GistFile(
            file,
            _controller.view,
            height: fileHeight,
          );
        }
        return Container(
          height: fileHeight + 10.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
