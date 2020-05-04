import 'package:flutter/material.dart';
import 'package:socialgist/model/Gist.dart';

///
///
///
class GistHeader extends StatelessWidget {
  final Gist gist;

  ///
  ///
  ///
  const GistHeader({Key key, this.gist}) : super(key: key);

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
              backgroundImage: NetworkImage(gist.owner.avatarUrl),
              backgroundColor: Colors.black54,
              radius: 24.0,
            ),
          ],
        ),
      ),
      title: Text(gist.owner.login),
      subtitle: Text(
        gist.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
