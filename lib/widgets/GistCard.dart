import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';
import 'package:socialgist/widgets/CardButton.dart';

import 'GistContent.dart';

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
            GistCard(widget.gist),
            GistContent(widget.gist, _controller.view, 150.0),
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
                      PublicGistProvider provider = PublicGistProvider(context);
                      // ignore: unawaited_futures
                      provider.putEmpty([widget.gist.id, 'star']);
                      await _controller.forward().orCancel;
                      await _controller.reverse().orCancel;
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
