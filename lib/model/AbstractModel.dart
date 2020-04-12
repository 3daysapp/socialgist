///
///
///
abstract class AbstractModel<T> {
  ///
  ///
  ///
  AbstractModel();

  ///
  ///
  ///
  AbstractModel.fromJson(Map<String, dynamic> json);

  ///
  ///
  ///
  Map<String, dynamic> toJson();

  ///
  ///
  ///
  T fromJson(Map<String, dynamic> json);
}
