import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';
import 'package:rift/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VeilNetAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const VeilNetAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final serviceTier = ref.watch(userServiceTierProvider);
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
          onPressed: () async {
            await supabase.auth.signOut();
            if (context.mounted) {
              context.go('/login');
            }
          },
          icon: const Icon(Icons.logout),
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
