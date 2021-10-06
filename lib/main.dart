import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';
import 'pages/home.dart';
import 'providers/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    child: const MyApp(),
    overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Movie Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary),
        buttonTheme: const ButtonThemeData(buttonColor: AppColors.buttonPrimary),
      ),
      home: const HomePage(),
    );
  }
}
