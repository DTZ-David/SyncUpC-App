// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/config/route_provider.dart';
import 'config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: SyncUpcApp(),
    ),
  );
}

class SyncUpcApp extends ConsumerWidget {
  const SyncUpcApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routers = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'SyncUPC',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: routers,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('es'),
      ],
    );
  }
}
