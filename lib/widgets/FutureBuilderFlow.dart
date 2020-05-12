import 'package:flutter/cupertino.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/util/ColumnMessage.dart';
import 'package:socialgist/util/WaitingMessage.dart';

///
///
///
class FutureBuilderFlow<T> extends StatelessWidget {
  final T initialData;
  final Future<T> future;
  final Widget Function(BuildContext context, T data) dataBuilder;

  ///
  ///
  ///
  const FutureBuilderFlow({
    Key key,
    this.initialData,
    this.future,
    this.dataBuilder,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return dataBuilder(context, snapshot.data);
        }

        if (snapshot.hasError) {
          return ColumnMessage(
            errorMessage: snapshot.error,
          );
        }

        return WaitingMessage('Loading...'.i18n);
      },
    );
  }
}
