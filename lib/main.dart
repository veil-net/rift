import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/plane/plane_detail.dart';
import 'package:rift/models/plane.dart';
import 'package:rift/pages/auth_page.dart';
import 'package:rift/pages/home_page.dart';
import 'package:rift/pages/settings_page.dart';
import 'package:rift/providers/session_provider.dart';
import 'package:rift/providers/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'tray_warpper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  await Supabase.initialize(
    url: 'https://supabase.veilnet.org',
    anonKey: 'sb_publishable_eNJQSWUp-w9RTIs2V4UDHw_ILjAP_xr',
  );

  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final theme = ref.watch(themeProviderProvider);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthPage(),
          redirect: (context, state) {
            if (session.value != null) {
              return '/home';
            }
            return null;
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
          redirect: (context, state) {
            if (session.value == null) {
              return '/';
            }
            return null;
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/plane/:id',
          builder: (context, state) => PlaneDetail(plane: state.extra as Plane),
        ),
      ],
    );

    final app = MaterialApp.router(
      title: 'VeilNet Rift',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 165, 233),
          primary: const Color.fromARGB(255, 14, 165, 233),
          secondary: const Color.fromARGB(255, 139, 92, 246),
          surface: const Color.fromARGB(255, 250, 250, 249),
          surfaceContainer: const Color.fromARGB(255, 214, 211, 209),
          surfaceContainerHigh: const Color.fromARGB(255, 231, 229, 228),
          surfaceContainerHighest: const Color.fromARGB(255, 245, 245, 244),
          surfaceContainerLow: const Color.fromARGB(255, 168, 162, 158),
          surfaceContainerLowest: const Color.fromARGB(255, 120, 113, 108),
          outline: const Color.fromARGB(255, 12, 10, 9),
          error: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 165, 233),
          primary: const Color.fromARGB(255, 14, 165, 233),
          secondary: const Color.fromARGB(255, 139, 92, 246),
          surface: const Color.fromARGB(255, 12, 10, 9),
          surfaceContainer: const Color.fromARGB(255, 68, 64, 60),
          surfaceContainerHigh: const Color.fromARGB(255, 87, 83, 78),
          surfaceContainerHighest: const Color.fromARGB(255, 120, 113, 108),
          surfaceContainerLow: const Color.fromARGB(255, 41, 37, 36),
          surfaceContainerLowest: const Color.fromARGB(255, 28, 25, 23),
          outline: const Color.fromARGB(255, 250, 250, 249),
          error: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: theme.value,
      routerConfig: router,
    );

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return TrayWrapper(child: app); // wrap only on desktop
    }

    return app;
  }
}
