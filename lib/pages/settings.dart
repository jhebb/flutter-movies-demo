import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settingsController = watch(settingsProvider.notifier);
    final settings = watch(settingsProvider);

    void handleChange(bool value) {
      settingsController.save('isRatingsForPreviewsEnabled', value);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          Row(
            children: [
              Switch(
                value: settings.isRatingsForPreviewsEnabled,
                onChanged: handleChange,
              ),
              const Text('Show ratings for movie previews'),
            ],
          ),
        ],
      ),
    );
  }
}
