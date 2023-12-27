import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/service/preferences.dart';
import 'l10n/l10n.dart' as l10n;
import 'navigation.dart' as nav;
import 'providers.dart';
import 'screens/splash_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();
  final riverpodRootContainer = ProviderContainer(
    overrides: [
      appPrefsServiceProvider.overrideWithValue(AppPrefsService(sharedPrefs)),
    ],
  );

  final assembledContainer = riverpodRootContainer;

  runApp(
    ProviderScope(
      parent: assembledContainer,
      child: const YolloApp(),
    ),
  );
}

class YolloApp extends StatelessWidget {
  const YolloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: l10n.AppLocalizations.supportedLocales,
      localizationsDelegates: l10n.AppLocalizationsX.localizationsDelegates,
      locale: const Locale('tk'),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      navigatorKey: nav.rootNavigatorKey,
      scaffoldMessengerKey: nav.scaffoldMessengerKey,
      home: const SplashScreen(),
    );
  }
}
