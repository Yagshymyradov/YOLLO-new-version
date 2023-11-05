import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation.dart' as nav;
import 'screens/authorization/authorization_screen.dart';
import 'theme.dart';

void main() {
  runApp(const ProviderScope(child: YolloApp()));
}

class YolloApp extends StatelessWidget {
  const YolloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.darkTheme,
      navigatorKey: nav.rootNavigatorKey,
      scaffoldMessengerKey: nav.scaffoldMessengerKey,
      home: const AuthorizationScreen(),
    );
  }
}
