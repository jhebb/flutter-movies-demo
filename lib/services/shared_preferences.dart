import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/shared_preferences.dart';

final sharedPreferencesServiceProvider = Provider((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);

  return SharedPreferencesService(sharedPreferences);
});

class SharedPreferencesService {
  SharedPreferencesService(this._prefs);

  final SharedPreferences _prefs;

  bool getSetting(String key) {
    return _prefs.getBool(key) ?? false;
  }

  Future<void> saveSetting(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
}
