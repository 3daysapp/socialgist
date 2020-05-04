import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialgist/model/Gist.dart';

///
///
///
class GistDate extends StatelessWidget {
  final Gist gist;

  ///
  ///
  ///
  const GistDate(this.gist, {Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    String languageTag = Localizations.localeOf(context).toLanguageTag();
    DateTime dateTime = gist.createdAtDate.toLocal();
    return Padding(
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
              DateFormat.yMd(languageTag).format(dateTime) +
                  ' ' +
                  DateFormat.Hms(languageTag).format(dateTime),
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
