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
    final portalSession =
        isPublic
            ? ref.watch(publicPortalSessionsByIdProvider(portal.id))
            : ref.watch(privatePortalSessionsByIdProvider(portal.id));

    return GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: portalSession.when(
              data: (data) => Icon(Icons.check_circle, color: Colors.green),
              error: (error, stack) => Icon(
                Icons.offline_bolt,
                color: Theme.of(context).colorScheme.error,
              ),
              loading:
                  () => CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
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
            trailing: portalSession.when(
              data:
                  (data) => Text(
                    data.cidr,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              error:
                  (error, stack) => Text(
                    'Offline',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              loading:
                  () => Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
