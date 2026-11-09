import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/app_core.dart';
import 'package:news_app/theme/app_theme.dart';

import 'controllers/font_controller.dart';
import 'controllers/language_controller.dart';
import 'controllers/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    themeController.load(),
    fontController.load(),
    languageController.load(),
  ]);
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable:  Listenable.merge([
        themeController,
        fontController,
        languageController,
      ]),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppCore(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.mode,
        locale: languageController.locale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(fontController.scale),
          ),
          child: child!,
        ),
      ),
    );
  }
}
