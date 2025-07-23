// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncupc/config/route_provider.dart';
import 'config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Supabase.initialize(
    url: "https://osavzgjbmuazpsyeqjfv.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9zYXZ6Z2pibXVhenBzeWVxamZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMzMDU5MTYsImV4cCI6MjA2ODg4MTkxNn0.64PbEO6H4IOuITkI01Ccm_0zIt6l4yscrDsuR8_JGGQ",
  );
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
