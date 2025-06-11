import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/user_provider.dart';
import '../screens/daemon_screen.dart';
import 'toast.dart';

class CustomAppBar extends HookConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userServiceTier = ref.watch(userServiceTierProvider);

    Future<void> logout() async {
      try {
        await supabase.auth.signOut();
      } on AuthException catch (e) {
        if (context.mounted) {
          ToastManager.showError(context, e.message);
        }
      } catch (e) {
        if (context.mounted) {
          ToastManager.showError(context, e.toString());
        }
      }
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(100),
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset('assets/images/icon.png', width: 32, height: 32),
              const SizedBox(width: 16),
              if (userServiceTier.value == 0)
                ActionChip(
                  label: Text('Community'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    ref.invalidate(userServiceTierProvider);
                    if (context.mounted) {
                      ToastManager.showSuccess(
                        context,
                        'Subscription tier refreshed',
                      );
                    }
                  },
                ),
              if (userServiceTier.value == 1)
                ActionChip(
                  label: Text('Adventurer'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    if (context.mounted) {
                      ToastManager.showInfo(
                        context,
                        'Refreshing subscription tier...',
                      );
                    }
                    ref.invalidate(userServiceTierProvider);
                    if (context.mounted) {
                      ToastManager.showSuccess(
                        context,
                        'Subscription tier refreshed',
                      );
                    }
                  },
                ),
              if (userServiceTier.value == 2)
                ActionChip(
                  label: Text('Team'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    if (context.mounted) {
                      ToastManager.showInfo(
                        context,
                        'Refreshing subscription tier...',
                      );
                    }
                    ref.invalidate(userServiceTierProvider);
                    if (context.mounted) {
                      ToastManager.showSuccess(
                        context,
                        'Subscription tier refreshed',
                      );
                    }
                  },
                ),
              if (userServiceTier.value == 3)
                ActionChip(
                  label: Text('Guild'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    if (context.mounted) {
                      ToastManager.showInfo(
                        context,
                        'Refreshing subscription tier...',
                      );
                    }
                    ref.invalidate(userServiceTierProvider);
                    if (context.mounted) {
                      ToastManager.showSuccess(
                        context,
                        'Subscription tier refreshed',
                      );
                    }
                  },
                ),
              const SizedBox(width: 16),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                launchUrl(Uri.parse('https://www.veilnet.org'));
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
              child: Text(
                'Help',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                launchUrl(Uri.parse('https://console.veilnet.org'));
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
              child: Text(
                'Console',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            if (!Platform.isAndroid)
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaemonScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.terminal,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            IconButton(
              onPressed: logout,
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
