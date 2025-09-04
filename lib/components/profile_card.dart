import 'package:rift/providers/conflux_provider.dart';
import 'package:rift/providers/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final conflux = ref.watch(confluxProvider);

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      builder:
          (context, value, child) => Opacity(
            opacity: value,
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: userProfile.when(
                      data:
                          (data) => Text(
                            data.username ?? 'No username',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      error:
                          (error, stackTrace) => Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              Expanded(
                                child: Text(
                                  error.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                      loading: () => const LinearProgressIndicator(),
                    ),
                    subtitle: userProfile.when(
                      data: (data) => Text(data.email),
                      error:
                          (error, stackTrace) => Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              Expanded(
                                child: Text(
                                  error.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      loading: () => const LinearProgressIndicator(),
                    ),
                    trailing: userProfile.when(
                      data:
                          (data) => Text(
                            data.mp.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      error:
                          (error, stackTrace) => Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              Expanded(
                                child: Text(
                                  error.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: Card(
                          color: Theme.of(context).colorScheme.surface,
                          child: ListTile(
                            leading: Icon(
                              Icons.cyclone,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: conflux.when(
                              data:
                                  (data) => Text(
                                    '${data.where((conflux) => conflux.portal).length}',
                                  ),
                              error:
                                  (error, stackTrace) => Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      Expanded(
                                        child: Text(
                                          error.toString(),
                                          style: TextStyle(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.error,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              loading: () => const LinearProgressIndicator(),
                            ),
                            subtitle: Text(
                              'Portals',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Theme.of(context).colorScheme.surface,
                          child: ListTile(
                            leading: Icon(
                              Icons.electric_bolt,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: conflux.when(
                              data:
                                  (data) => Text(
                                    '${data.where((conflux) => !conflux.portal).length}',
                                  ),
                              error:
                                  (error, stackTrace) => Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      Expanded(
                                        child: Text(
                                          error.toString(),
                                          style: TextStyle(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.error,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              loading: () => const LinearProgressIndicator(),
                            ),
                            subtitle: Text(
                              'Rifts',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
