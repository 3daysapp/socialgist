import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';

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
          label: '${gist.files.length} Arquivo'
              '${gist.files.length > 1 ? 's' : ''}',
          onPressed: () {},
        ),
        CardButton(
          iconData: FontAwesomeIcons.solidComments,
          label: '${gist.comments} Comentário'
              '${gist.comments > 1 ? 's' : ''}',
          onPressed: () {},
        ),
        CardButton(
          iconData: FontAwesomeIcons.solidStar,
          label: 'Star',
          onPressed: () async {
            try {
              PublicGistProvider provider = PublicGistProvider(context);
              // ignore: unawaited_futures
              provider.putEmpty([gist.id, 'star']);
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
