import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/provider/PublicGistProvider.dart';
import 'package:socialgist/util/CodeHighlight.dart';

///
///
///
class GistContent extends StatelessWidget {
  final Gist gist;
  final double fileHeight;
  final Animation<double> controller;
  final Animation<double> opacity;

  ///
  ///
  ///
  GistContent(
    this.gist,
    this.controller,
    this.fileHeight, {
    Key key,
  })  : opacity = Tween<double>(
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
      future: PublicGistProvider(context).getObject([gist.id]),
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
                    CodeHighlight(file, height: fileHeight),
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
          height: (fileHeight ?? 80.0) + 10.0,
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
