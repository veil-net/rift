import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/matrix_rain_background.dart';

import '../providers/user_provider.dart';
import '../screens/auth_screen.dart';

class AuthGuard extends HookConsumerWidget {
  const AuthGuard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.session == null
        ? const AuthScreen()
        : MatrixRainBackground(child: child);
  }
}
