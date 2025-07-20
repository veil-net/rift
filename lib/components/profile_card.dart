import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/providers/conflux_provider.dart';
import 'package:rift/providers/user_provider.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final confluxes = ref.watch(confluxesProvider);

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.wallet,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                profile.when(
                  data: (data) => "Your MP: ${data.mp}",
                  error: (error, stackTrace) => 'Failed to load MP credits',
                  loading: () => 'Loading...',
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.help),
                onPressed: () {
                  DialogManager.showDialog(
                    context,
                    'The MP (Measurement of Participation) system enables users to access VeilNet services without a subscription. Users can earn MP by self-hosting VeilNet Portals under public domains, with each Portal generating 1 MP per second. These MP are then consumed by the user’s Public Rifts at the same rate. This system incentivizes community hosting and rewards users with continued access to the network in a decentralized, contribution-based model.',
                    DialogType.info,
                  );
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(
                          Icons.cyclone,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        title: Text(
                          '${confluxes.when(data: (data) => data.where((conflux) => conflux.portal == true).length, error: (error, stackTrace) => 0, loading: () => 0)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(
                          'Portals',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      context.push('/portal');
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(
                          Icons.electric_bolt,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        title: Text(
                          '${confluxes.when(data: (data) => data.where((conflux) => conflux.portal == false).length, error: (error, stackTrace) => 0, loading: () => 0)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(
                          'Rifts',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      context.push('/rift');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
