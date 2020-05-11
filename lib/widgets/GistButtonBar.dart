import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/GistProvider.dart';

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
        CardButton(
          iconData: FontAwesomeIcons.solidFile,
          label: '%d Files'.plural(gist.files.length),
          onPressed: null,
        ),
        CardButton(
          iconData: FontAwesomeIcons.solidComments,
          label: '%d Comments'.plural(gist.comments),
          onPressed: null,
        ),
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
