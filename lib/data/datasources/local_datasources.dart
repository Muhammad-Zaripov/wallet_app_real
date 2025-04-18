import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasources {
  LocalDatasources._singleton();
  static final _private = LocalDatasources._singleton();
  factory LocalDatasources() {
    return _private;
  }

  static const String _limitCostKey = 'limitCost';

  Future<void> saveLimitCost({required int limitCost}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_limitCostKey, limitCost);
  }

  Future<int> getLimitCost() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_limitCostKey) ?? 0;
  }
}
