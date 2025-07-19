import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/conflux_provider.dart';

import 'glass_card.dart';

class PortalCard extends HookConsumerWidget {
  final Conflux conflux;
  const PortalCard({super.key, required this.conflux});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:
                conflux.signature != null
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(
                      Icons.offline_bolt,
                      color: Theme.of(context).colorScheme.error,
                    ),
            title: Text(
              conflux.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              conflux.tag ?? '',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing:
                conflux.signature != null
                    ? Text(
                      conflux.cidr ?? '',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                    : Text(
                      'Offline',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
