import 'package:flutter/material.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/provider/GistProvider.dart';
import 'package:socialgist/util/ColumnMessage.dart';
import 'package:socialgist/view/GistDetail.dart';
import 'package:socialgist/widgets/GistButtonBar.dart';
import 'package:socialgist/widgets/DateFormatted.dart';
import 'package:socialgist/widgets/GistFile.dart';
import 'package:socialgist/widgets/GistHeader.dart';

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
                  DateFormatted(widget.gist.createdAtDate.toLocal()),
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
      future: GistProvider(context: context).getById(widget.gist.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          localGist = snapshot.data;

          if (localGist.files == null || localGist.files.isEmpty) {
            return Center(child: Text('File not found!'.i18n));
          }

          File file = localGist.files.first;

          return GistFile(
            file,
            _controller.view,
            height: fileHeight,
          );
        }

        if (snapshot.hasError) {
          return ColumnMessage(
            errorMessage: snapshot.error,
          );
        }

        return Container(
          height: fileHeight + 8, // Todo - Doing scroll steps.
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Loading...'.i18n),
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
