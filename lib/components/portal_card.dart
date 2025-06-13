import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/portal_provider.dart';
import 'glass_card.dart';

class PortalCard extends HookConsumerWidget {
  final Portal portal;
  final bool isPublic;
  const PortalCard({super.key, required this.portal, required this.isPublic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:
                portal.online
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(
                      Icons.offline_bolt,
                      color: Theme.of(context).colorScheme.error,
                    ),
            title: Text(
              portal.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              portal.tag ?? '',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing:
                portal.online
                    ? Text(
                      portal.cidr ?? '',
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
