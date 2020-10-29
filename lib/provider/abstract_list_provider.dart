import 'package:socialgist/model/abstract_model.dart';

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
