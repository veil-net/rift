import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/main.dart';
import 'package:rift/providers/notification_provider.dart';
import 'package:rift/providers/user_provider.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VeilNetAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const VeilNetAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final serviceTier = ref.watch(userServiceTierProvider);
    final notifications = ref.watch(notificationProvider);
    final veilnetState = ref.watch(veilnetProvider);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Hero(tag: 'logo', child: Image.asset('assets/images/icon.png')),
      title: serviceTier.when(
        data:
            (data) => ActionChip(
              label: Text(
                switch (data) {
                  0 => 'Community',
                  1 => 'Adventurer',
                  2 => 'Team',
                  _ => 'Unknown',
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () {
                ref.invalidate(userServiceTierProvider);
              },
            ),
        error: (error, stackTrace) => const ActionChip(label: Text('Error')),
        loading: () => const ActionChip(label: Text('Loading...')),
      ),
      actions: [
        notifications.when(
          data:
              (data) => IconButton(
                onPressed:
                    data.isEmpty
                        ? () {
                          DialogManager.showDialog(
                            context,
                            "No notifications",
                            DialogType.info,
                          );
                        }
                        : () {
                          context.push('/notifications');
                        },
                icon: Icon(
                  Icons.notifications,
                  color:
                      data.isEmpty
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                ),
              ),
          error:
              (error, stackTrace) => IconButton(
                onPressed: () {
                  DialogManager.showDialog(
                    context,
                    "Failed to load notifications",
                    DialogType.error,
                  );
                },
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
          loading: () => const CircularProgressIndicator(),
        ),
        TextButton(
          onPressed: () {
            launchUrl(Uri.parse('https://www.veilnet.org'));
          },
          child: Text(
            'Help',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
          child: Text(
            'Console',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        IconButton(
          onPressed:
              veilnetState.isBusy
                  ? null
                  : () async {
                    await supabase.auth.signOut();
                    if (veilnetState.isConnected) {
                      ref.read(veilnetProvider.notifier).disconnect();
                    }
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
          icon: Icon(
            Icons.logout,
            color: veilnetState.isBusy
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
