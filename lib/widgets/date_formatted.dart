import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


///
///
///
class DateFormatted extends StatelessWidget {
  final DateTime dateTime;

  ///
  ///
  ///
  const DateFormatted(this.dateTime, {Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    String languageTag = Localizations.localeOf(context).toLanguageTag();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 4.0,
        right: 8.0,
      ),
      child: Text(
        DateFormat.yMd(languageTag).format(dateTime) +
            ' ' +
            DateFormat.Hms(languageTag).format(dateTime),
        style: TextStyle(
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}
