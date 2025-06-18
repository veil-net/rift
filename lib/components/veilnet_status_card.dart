import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/glass_card.dart';
import 'dart:async';

import '../providers/rift_provider.dart';
import '../providers/veilnet_provider.dart';
import '../providers/portal_provider.dart';
import '../screens/portal_screen.dart';
import '../providers/user_provider.dart';
import 'dialog.dart';

class DaemonStatusCard extends HookConsumerWidget {
  const DaemonStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilnet = ref.watch(veilnetNotifierProvider);
    final veilnetNotifier = ref.watch(veilnetNotifierProvider.notifier);
    final userProfile = ref.watch(userProfileProvider);
    final publicPortals = ref.watch(portalProvider(true));
    final privatePortals = ref.watch(portalProvider(false));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        ref.invalidate(userProfileProvider);
      });
      return () => timer.cancel();
    }, []);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Your MP:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userProfile.when(
                        data: (data) => data.mp.toString(),
                        error: (error, stack) => 'Error',
                        loading: () => 'Loading...',
                      ),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.help),
                      onPressed: () {
                        DialogManager.showDialog(
                          context,
                          'The MP (Minutes of Participation) system enables users to access VeilNet services without a subscription. Users can earn MP by self-hosting VeilNet Portals under public domains, with each Portal generating 1 MP per second. These MP are then consumed by the user’s Public Rifts at the same rate. This system incentivizes community hosting and rewards users with continued access to the network in a decentralized, contribution-based model.',
                          DialogType.info,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Text(
                'Your Portals:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      child: ListTile(
                        leading: Icon(
                          Icons.cyclone,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        title: publicPortals.when(
                          data:
                              (data) => Text(
                                '${data.where((portal) => portal.online).length}/${data.length}',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          error:
                              (error, stack) => Text(
                                'Error',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                          loading:
                              () => Text(
                                'Loading...',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                        ),
                        subtitle: Text(
                          'Public',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PortalScreen(isPublic: true),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GlassCard(
                      child: ListTile(
                        leading: Icon(
                          Icons.cyclone,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        title: privatePortals.when(
                          data:
                              (data) => Text(
                                '${data.where((portal) => portal.online).length}/${data.length}',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          error:
                              (error, stack) => Text(
                                'Error',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                          loading:
                              () => Text(
                                'Loading...',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                        ),
                        subtitle: Text(
                          'Private',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PortalScreen(isPublic: false),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              veilnet.isConnected
                  ? ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text(
                      'Connected To',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Unknown',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () async {
                            try {
                              await veilnetNotifier.disconnect();
                            } catch (e) {
                              if (context.mounted) {
                                DialogManager.showDialog(
                                  context,
                                  'Failed to disconnect from domain: $e',
                                  DialogType.error,
                                );
                              }
                            } finally {
                              ref.invalidate(riftProvider(true));
                              ref.invalidate(riftProvider(false));
                            }
                          },
                          icon: const Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text(
                      'Disconnected',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
