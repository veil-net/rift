import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/service_tier_provider.dart';

class VeilnetAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const VeilnetAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceTier = ref.watch(serviceTierProvider);
    final serviceTierNotifier = ref.watch(serviceTierProvider.notifier);
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
                serviceTierNotifier.refresh();
              },
            ),
        error: (error, stackTrace) => const ActionChip(label: Text('Error')),
        loading: () => const ActionChip(label: Text('Loading...')),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
