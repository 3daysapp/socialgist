import 'package:socialgist/model/AbstractModel.dart';

///
///
///
abstract class AbstractListProvider<T extends AbstractModel> {
  ///
  ///
  ///
  bool get hasNext;

  ///
  ///
  ///
  Future<List<T>> get();

  ///
  ///
  ///
  Future<List<T>> next();
}
