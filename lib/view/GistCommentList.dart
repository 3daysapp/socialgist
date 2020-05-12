import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/GistComment.dart';
import 'package:socialgist/provider/AbstractListProvider.dart';
import 'package:socialgist/util/ColumnMessage.dart';
import 'package:socialgist/util/WaitingMessage.dart';
import 'package:socialgist/widgets/DateFormatted.dart';
import 'package:socialgist/widgets/DefaultScaffold.dart';
import 'package:socialgist/widgets/UserTile.dart';

///
///
///
class GistCommentList extends StatefulWidget {
  final String title;
  final AbstractListProvider provider;

  ///
  ///
  ///
  const GistCommentList({
    Key key,
    @required this.title,
    @required this.provider,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _GistCommentListState createState() => _GistCommentListState();
}

///
///
///
class _GistCommentListState extends State<GistCommentList> {
  List<GistComment> _comments;
  ScrollController _scrollController;
  AbstractListProvider _providerHolder;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _providerHolder = widget.provider;

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent -
              (MediaQuery.of(context).size.height * 0.4)) {
        if (!_loading && _providerHolder.hasNext) {
          _nextData();
        }
      }
    });

    _loadData();
  }

  ///
  ///
  ///
  void _loadData() async {
    if (mounted) setState(() => _loading = true);
    _comments = [];
    List<GistComment> comments = await _providerHolder.get();
    _comments.addAll(comments);
    if (mounted) setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    if (mounted) setState(() => _loading = true);
    List<GistComment> comments = await _providerHolder.next();
    _comments.addAll(comments);
    if (mounted) setState(() => _loading = false);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      subtitle: widget.title,
      body: Builder(builder: (context) {
        if (_comments == null) {
          return WaitingMessage('Loading...'.i18n);
        }

        if (_comments.isEmpty) {
          return ColumnMessage(
            message: 'Nobody around here.'.i18n,
          );
        }

        return Stack(
          children: <Widget>[
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                GistComment comment = _comments[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      UserTile(comment.user),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.white24,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            comment.body ?? '',
                            style: GoogleFonts.firaMono(fontSize: 12.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: DateFormatted(comment.updatedAtDate.toLocal()),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _comments.length,
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
}
