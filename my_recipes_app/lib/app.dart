import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_recipes_app/l10n/app_localizations.dart';
import 'package:my_recipes_app/ui/pages/splash_screen_page.dart';
import 'package:my_recipes_app/viewmodels/locale_viewmodel.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localVM = context.watch<LocaleViewmodel>();
    final locale = localVM.locale ?? const Locale('en'); 
    return MaterialApp(
      title: 'MyRecipes',
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // Inglés
        Locale('ca'), // Valenciano
      ],
      home: const SplashScreen(),
    );
  }
}
