import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';
import 'package:socialgist/util/CodeHighlight.dart';

///
///
///
class Gists extends StatefulWidget {
  ///
  ///
  ///
  @override
  _GistsState createState() => _GistsState();
}

///
///
///
class _GistsState extends State<Gists> {
  final PublicGistProvider _provider = PublicGistProvider(perPage: 5);
  ScrollController _scrollController;
  final SplayTreeMap<String, Gist> _gists =
      SplayTreeMap((i, j) => j.compareTo(i));
  bool _loading = true;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent -
              (MediaQuery
                  .of(context)
                  .size
                  .height * 0.4)) {
        if (!_loading && _provider.hasNext) {
          _nextData();
        }
      }
    });

    _initialData();
  }

  ///
  ///
  ///
  Future<void> _initialData() async {
    setState(() => _loading = true);
    List<Gist> gists = await _provider.getList(['public']);
    _gists.clear();
    _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  Future<void> _nextData() async {
    setState(() => _loading = true);
    List<Gist> gists = await _provider.getNextList(['public']);
    _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
    setState(() => _loading = false);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RefreshIndicator(
        onRefresh: () async {
          List<Gist> gists = await _provider.getList(['public']);
          _gists.clear();
          _gists.addAll({for (Gist gist in gists) gist.createdAt: gist});
          setState(() => _loading = false);
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                children: _gists.values
                    .map(
                      (gist) => GistWidget(gist),
                )
                    .toList(),
              ),
            ),
            Visibility(
              visible: _loading,
              child: Container(
                height: 60.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///
///
///
class GistWidget extends StatefulWidget {
  final Gist gist;

  ///
  ///
  ///
  const GistWidget(this.gist, {Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _GistWidgetState createState() => _GistWidgetState();
}

///
///
///
class _GistWidgetState extends State<GistWidget> with TickerProviderStateMixin {
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                      NetworkImage(widget.gist.owner.avatarUrl),
                      backgroundColor: Colors.black54,
                      radius: 24.0,
                    ),
                  ],
                ),
              ),
              title: Text(widget.gist.owner.login),
              subtitle: Text(widget.gist.description ?? ''),
            ),
            GistContent(widget.gist, _controller.view),
            ButtonBar(
              children: <Widget>[
                CardButton(
                  iconData: FontAwesomeIcons.solidFile,
                  label: '${widget.gist.files.length} Arquivo'
                      '${widget.gist.files.length > 1 ? 's' : ''}',
                  onPressed: () {},
                ),
                CardButton(
                  iconData: FontAwesomeIcons.solidComments,
                  label: '${widget.gist.comments} Comentário'
                      '${widget.gist.comments > 1 ? 's' : ''}',
                  onPressed: () {},
                ),
                CardButton(
                  iconData: FontAwesomeIcons.solidStar,
                  label: 'Star',
                  onPressed: () async {
                    try {
                      PublicGistProvider provider = PublicGistProvider();
                      // ignore: unawaited_futures
                      provider.putEmpty([widget.gist.id, 'star']);
                      await _controller
                          .forward()
                          .orCancel;
                      await _controller
                          .reverse()
                          .orCancel;
                    } on TickerCanceled {
                      // the animation got canceled, probably because we were disposed
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
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

///
///
///
class GistContent extends StatelessWidget {
  final Gist gist;
  final Animation<double> controller;
  final Animation<double> opacity;

  ///
  ///
  ///
  GistContent(this.gist, this.controller, {Key key})
      : opacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.easeIn,
      ),
      reverseCurve: Interval(
        0.0,
        0.2,
        curve: Curves.easeOut,
      ),
    ),
  ),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Gist>(
      future: PublicGistProvider().getObject([gist.id]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Gist newGist = snapshot.data;

          if (newGist.files == null || newGist.files.isEmpty) {
            return Text('No File!');
          }

          File file = newGist.files.first;
          DateTime createdAt = DateTime.parse(newGist.createdAt);

          return Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 4.0,
              right: 8.0,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 4.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        file.filename.substring(
                            0,
                            file.filename.length < 35
                                ? file.filename.length
                                : 35),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        '${file.language ?? file.type}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CodeHighlight(file, height: 150.0),
                    FadeTransition(
                      opacity: opacity,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.solidStar,
                          size: 42,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 4.0,
                    right: 8.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          DateFormat.yMd('pt_BR').format(createdAt.toLocal()) +
                              ' ' +
                              DateFormat.Hms('pt_BR')
                                  .format(createdAt.toLocal()),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container(
          height: 160.0,
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
}

///
///
///
class CardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData iconData;
  final double height;

  ///
  ///
  ///
  const CardButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    @required this.iconData,
    this.height = 40.0,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FittedBox(
        child: FlatButton.icon(
          onPressed: onPressed,
          icon: FaIcon(iconData),
          label: Text(label),
        ),
      ),
    );
  }
}
