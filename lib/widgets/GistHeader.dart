import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/util/Config.dart';

///
///
///
class GistHeader extends StatelessWidget {
  final Gist gist;

  ///
  ///
  ///
  const GistHeader(this.gist, {Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              child: Config().test ? FaIcon(FontAwesomeIcons.solidSmile) : null,
              backgroundImage:
                  Config().test ? null : NetworkImage(gist.owner.avatarUrl),
              backgroundColor: Colors.black54,
              radius: 24.0,
            ),
          ],
        ),
      ),
      title: Text(Config().test ? 'SocialGist' : gist.owner.login),
      subtitle: Text(
        gist.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
