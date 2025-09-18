import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/pages/home_page.dart';
import 'package:rift/pages/landing_page.dart';
import 'package:rift/pages/login_page.dart';
import 'package:rift/pages/notification_page.dart';
import 'package:rift/pages/password_reset_page.dart';
import 'package:rift/pages/portal_page.dart';
import 'package:rift/pages/register_page.dart';
import 'package:rift/pages/rift_page.dart';
import 'package:rift/pages/verify_email_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/user_provider.dart';
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
    anonKey:
        'sb_publishable_eNJQSWUp-w9RTIs2V4UDHw_ILjAP_xr',
  );

  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LandingPage(),
          redirect: (context, state) async {
            // Handle refresh token
            final refreshToken = state.uri.queryParameters['refreshToken'];
            if (refreshToken != null) {
              await supabase.auth.setSession(refreshToken);
            }
            // Check if user is logged in
            await Future.delayed(const Duration(seconds: 1));
            final userState = ref.read(userProvider);
            if (userState.session != null) {
              return '/home';
            }
            return '/login';
          },
        ),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/verify-email',
          builder: (context, state) => VerifyEmailPage(email: state.extra as String?),
        ),
        GoRoute(
          path: '/password-reset',
          builder: (context, state) => const PasswordResetPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
          redirect: (context, state) {
            final userState = ref.read(userProvider);
            return userState.session == null ? '/login' : null;
          },
        ),
        GoRoute(
          path: '/portal',
          builder: (context, state) => const PortalPage(),
        ),
        GoRoute(path: '/rift', builder: (context, state) => const RiftPage()),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationPage(),
        ),
        GoRoute(
          path: '/callback',
          builder: (context, state) => const LandingPage(),
          redirect: (context, state) async {
            // Check if user is logged in
            await Future.delayed(const Duration(seconds: 1));
            final userState = ref.read(userProvider);
            if (userState.session != null) {
              return '/home';
            }
            return '/login';
          },
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
          surface: const Color.fromARGB(255, 12, 10, 9),
          surfaceContainer: const Color.fromARGB(255, 41, 37, 36),
          surfaceContainerHigh: const Color.fromARGB(255, 68, 64, 60),
          surfaceContainerHighest: const Color.fromARGB(255, 87, 83, 78),
          surfaceContainerLow: const Color.fromARGB(255, 28, 25, 23),
          surfaceContainerLowest: const Color.fromARGB(255, 12, 10, 9),
          outline: const Color.fromARGB(255, 120, 113, 108),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 165, 233),
          primary: const Color.fromARGB(255, 14, 165, 233),
          secondary: const Color.fromARGB(255, 139, 92, 246),
          surface: const Color.fromARGB(255, 12, 10, 9),
          surfaceContainer: const Color.fromARGB(255, 41, 37, 36),
          surfaceContainerHigh: const Color.fromARGB(255, 68, 64, 60),
          surfaceContainerHighest: const Color.fromARGB(255, 87, 83, 78),
          surfaceContainerLow: const Color.fromARGB(255, 28, 25, 23),
          surfaceContainerLowest: const Color.fromARGB(255, 12, 10, 9),
          outline: const Color.fromARGB(255, 120, 113, 108),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return TrayWrapper(child: app); // wrap only on desktop
    }

    return app;
  }
}
