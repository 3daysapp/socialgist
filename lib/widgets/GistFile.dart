import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialgist/model/Gist.dart';
import 'package:socialgist/util/CodeHighlight.dart';

///
///
///
class GistFile extends StatelessWidget {
  final File file;
  final double height;
  final Animation<double> controller;
  final Animation<double> opacity;

  ///
  ///
  ///
  GistFile(
    this.file,
    this.controller, {
    Key key,
    this.height,
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
                Flexible(
                  flex: 8,
                  child: Text(
                    file.filename,
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: height==null ? 10 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    '${file.language ?? file.type}',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w200,
                    ),
                    maxLines: height==null ? 10 : 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CodeHighlight(
                file,
                height: height,
              ),
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
        ],
      ),
    );
  }
}
