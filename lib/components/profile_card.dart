import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/conflux_provider.dart';
import 'package:rift/providers/user_provider.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final userProfile = ref.watch(userProfileProvider);
    final confluxes = ref.watch(confluxesProvider);
    final isBusy = useState(false);
    final usernameController = useTextEditingController();
    final formkey = useMemoized(() => GlobalKey<FormState>());

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        ref.invalidate(userProfileProvider);
        ref.invalidate(userServiceTierProvider);
      });
      return () {
        timer.cancel();
      };
    }, []);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            userProfile.when(
              data: (profile) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Text(profile.email.substring(0, 2).toUpperCase()),
                ),
                title: profile.username != null
                    ? Text(
                        profile.username!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : Form(
                        key: formkey,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                  hintText: 'Enter a username',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      usernameController.clear();
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                                autofillHints: [AutofillHints.username],
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            FilledButton(
                              onPressed: isBusy.value
                                  ? null
                                  : () async {
                                      if (!formkey.currentState!.validate()) {
                                        return;
                                      }
                                      isBusy.value = true;
                                      try {
                                        final api = ref.watch(apiProvider);
                                        await api.patch(
                                          '/auth/profile/username?username=${usernameController.text}',
                                        );
                                      } on DioException catch (e) {
                                        if (context.mounted) {
                                          DialogManager.showDialog(
                                            context,
                                            e.response?.data['detail'],
                                            DialogType.error,
                                          );
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          DialogManager.showDialog(
                                            context,
                                            e.toString(),
                                            DialogType.error,
                                          );
                                        }
                                      } finally {
                                        ref.invalidate(userProfileProvider);
                                        isBusy.value = false;
                                      }
                                    },
                              child: Text('Set'),
                            ),
                          ],
                        ),
                      ),
                subtitle: user.user?.emailConfirmedAt != null
                    ? Text(
                        profile.email,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      )
                    : TextButton(
                        onPressed: () {
                          context.push('/verify-email');
                        },
                        child: Text(
                          'Verify Email',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                trailing: Text(
                  '${profile.mp} MP',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      leading: confluxes.when(
                        data: (data) => Icon(
                          Icons.cyclone,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        error: (error, stackTrace) => Icon(
                          Icons.error,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        loading: () => CircularProgressIndicator(),
                      ),
                      title: confluxes.when(
                        data: (data) => Text(
                          '${data.where((conflux) => conflux.portal == true).length}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        error: (error, stackTrace) => Text('Error'),
                        loading: () => LinearProgressIndicator(),
                      ),
                      subtitle: confluxes.when(
                        data: (data) => Text(
                          'Portals',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        error: (error, stackTrace) => null,
                        loading: () => null,
                      ),
                      onTap: () {
                        context.push('/portal');
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card(
                    child: ListTile(
                      leading: confluxes.when(
                        data: (data) => Icon(
                          Icons.electric_bolt,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        error: (error, stackTrace) => Icon(
                          Icons.error,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        loading: () => CircularProgressIndicator(),
                      ),
                      title: confluxes.when(
                        data: (data) => Text(
                          '${data.where((conflux) => conflux.portal == false).length}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        error: (error, stackTrace) => Text('Error'),
                        loading: () => LinearProgressIndicator(),
                      ),
                      subtitle: confluxes.when(
                        data: (data) => Text(
                          'Rifts',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        error: (error, stackTrace) => null,
                        loading: () => null,
                      ),
                      onTap: () {
                        context.push('/rift');
                      },
                    ),
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
