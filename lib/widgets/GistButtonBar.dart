import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/GistCommentProvider.dart';
import 'package:socialgist/provider/GistProvider.dart';
import 'package:socialgist/view/GistCommentList.dart';

import 'CardButton.dart';

class GistButtonBar extends StatelessWidget {
  final Gist gist;
  final AnimationController controller;

  ///
  ///
  ///
  const GistButtonBar(this.gist, this.controller, {Key key}) : super(key: key);

  ///
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        /// Files
        CardButton(
          iconData: FontAwesomeIcons.solidFile,
          label: '%d Files'.plural(gist.files.length),
          onPressed: null,
        ),

        /// Comments
        CardButton(
          iconData: FontAwesomeIcons.solidComments,
          label: '%d Comments'.plural(gist.comments),
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
        CardButton(
          iconData: FontAwesomeIcons.solidStar,
          label: 'Star'.i18n,
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
      ],
    );
  }
}
