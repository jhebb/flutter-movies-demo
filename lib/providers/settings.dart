import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';
import '../services/shared_preferences.dart';

final settingsProvider = StateNotifierProvider<SettingsController, Settings>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);

  return SettingsController(sharedPreferencesService);
});

class SettingsController extends StateNotifier<Settings> {
  SettingsController(this._service)
      : super(Settings(isRatingsForPreviewsEnabled: _service.getSetting('isRatingsForPreviewsEnabled')));

  final SharedPreferencesService _service;

// TODO Make this more dynamic so settings of different types can be saved
// https://stackoverflow.com/questions/60853932/flutter-dart-dynamically-get-a-property-of-a-class
  void save(String setting, bool value) {
    state = state.copyWith(isRatingsForPreviewsEnabled: value);

    _service.saveSetting(setting, value);
  }
}
