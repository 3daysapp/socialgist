import 'package:flutter/foundation.dart';

///
/// https://developer.github.com/v3/#rate-limiting
///
class ApiUsage {
  /// The maximum number of requests you're permitted to make per hour.
  int _limit;

  /// The number of requests remaining in the current rate limit window.
  int _remaining;

  /// The time at which the current rate limit window resets in UTC epoch seconds.
  DateTime _reset;

  ///
  ///
  ///
  ApiUsage({
    @required String limit,
    @required String remaining,
    String reset,
  }) {
    _limit = int.tryParse(limit);
    _remaining = int.tryParse(remaining);
    if (reset != null && reset.isNotEmpty) {
      _reset = DateTime.fromMillisecondsSinceEpoch(int.tryParse(reset) * 1000);
    } else {
      _reset = DateTime.now();
    }
  }

  ///
  ///
  ///
  int get limit => _limit;

  ///
  ///
  ///
  int get remaining => _remaining;

  ///
  ///
  ///
  DateTime get reset => _reset;

  ///
  ///
  ///
  double get percent => _remaining.toDouble() / _limit.toDouble();

  ///
  ///
  ///
  @override
  String toString() {
    return (percent * 100.0).toStringAsFixed(2) +
        '% ($remaining de $limit) até ' +
        reset.toIso8601String();
  }
}
