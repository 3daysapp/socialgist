import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/GistCommentProvider.dart';
import 'package:socialgist/provider/GistProvider.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/view/GistCommentList.dart';

///
///
///
class GistButtonBar extends StatelessWidget {
  final Gist gist;
  final AnimationController controller;
  final bool defaultStarred;

  ///
  ///
  ///
  const GistButtonBar({
    @required this.gist,
    @required this.controller,
    @required this.defaultStarred,
    Key key,
  }) : super(key: key);

  ///
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: <Widget>[
          /// Files
          FlatButton.icon(
            icon: FaIcon(FontAwesomeIcons.file),
            label: Text('%d Files'.plural(gist.files.length)),
            onPressed: null,
          ),

          /// Comments
          FlatButton.icon(
            icon: FaIcon(FontAwesomeIcons.comments),
            label: Text('%d Comments'.plural(gist.comments)),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GistCommentList(
                  title: 'Comments'.i18n,
                  provider: GistCommentProvider(
                    context: context,
                    gist: gist,
                  ),
                ),
              ),
            ),
          ),

          /// Star
          defaultStarred
              ? IconButton(
                  icon: FaIcon(FontAwesomeIcons.solidStar),
                  tooltip: 'Starred'.i18n,
                  onPressed: () async {
                    try {
                      // ignore: unawaited_futures
                      GistProvider(context: context).unstar(gist);
                      await controller.forward().orCancel;
                      await controller.reverse().orCancel;
                    } on TickerCanceled {
                      // the animation got canceled, probably because we were disposed
                    }
                  },
                )
              : IconButton(
                  icon: FaIcon(FontAwesomeIcons.star),
                  tooltip: 'Star'.i18n,
                  onPressed: () async {
                    try {
                      // ignore: unawaited_futures
                      GistProvider(context: context).star(gist);
                      await controller.forward().orCancel;
                      await controller.reverse().orCancel;
                    } on TickerCanceled {
                      // the animation got canceled, probably because we were disposed
                    }
                  },
                ),

          /// Share
          if (!Config().isWeb)
            IconButton(
              icon: FaIcon(FontAwesomeIcons.shareAlt),
              tooltip: 'Share'.i18n,
              onPressed: () => Share.share(
                gist.htmlUrl,
                subject: 'Shared from SocialGist'.i18n,
              ),
            )
        ],
      ),
    );
  }
}
