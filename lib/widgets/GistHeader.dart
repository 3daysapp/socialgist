import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/view/UserProfile.dart';

///
///
///
class GistHeader extends StatelessWidget {
  final Gist gist;
  final Function onTap;

  ///
  ///
  ///
  const GistHeader(
    this.gist, {
    Key key,
    this.onTap,
  }) : super(key: key);

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
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfile(gist.owner),
                ),
              ),
              child: CircleAvatar(
                child:
                    Config().test ? FaIcon(FontAwesomeIcons.solidSmile) : null,
                backgroundImage: Config().test
                    ? null
                    : NetworkImage(gist.owner.avatarUrl),
                // TODO - Need cache.
                backgroundColor: Colors.black54,
                radius: 24.0,
              ),
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
      onTap: onTap,
    );
  }
}
