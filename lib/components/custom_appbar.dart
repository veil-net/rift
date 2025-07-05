import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/user_provider.dart';
import '../providers/veilnet_provider.dart';
import '../screens/daemon_screen.dart';
import 'dialog.dart';

class CustomAppBar extends HookConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userServiceTier = ref.watch(userServiceTierProvider);
    final veilnet = ref.watch(veilnetNotifierProvider);
    final veilnetNotifier = ref.watch(veilnetNotifierProvider.notifier);

    Future<void> logout() async {
      try {
        if (veilnet.isConnected) {
          await veilnetNotifier.disconnect();
        }
        await supabase.auth.signOut();
      } on AuthException catch (e) {
        if (context.mounted) {
          DialogManager.showDialog(context, e.message, DialogType.error);
        }
      } catch (e) {
        if (context.mounted) {
          DialogManager.showDialog(context, e.toString(), DialogType.error);
        }
      }
    }

    Future<void> refreshSubscriptionTier(
      BuildContext context,
      WidgetRef ref,
    ) async {
      if (context.mounted) {
        ref.invalidate(userServiceTierProvider);
        if (context.mounted) {
          DialogManager.showDialog(
            context,
            'Subscription tier refreshed',
            DialogType.success,
          );
        }
      }
    }

    ;

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
                      DialogManager.showDialog(
                        context,
                        'Subscription tier refreshed',
                        DialogType.success,
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
                  onPressed: () => refreshSubscriptionTier(context, ref),
                ),
              if (userServiceTier.value == 2)
                ActionChip(
                  label: Text('Team'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => refreshSubscriptionTier(context, ref),
                ),
              if (userServiceTier.value == 3)
                ActionChip(
                  label: Text('Guild'),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => refreshSubscriptionTier(context, ref),
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
                final refreshToken = userState.session?.refreshToken;
                if (refreshToken != null) {
                  launchUrl(
                    Uri.parse(
                      'https://console.veilnet.org?refreshToken=$refreshToken',
                    ),
                  );
                } else {
                  launchUrl(Uri.parse('https://console.veilnet.org'));
                }
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
