import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../providers/user_provider.dart';
import 'dialog.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 8),
          ListTile(
            leading: Image.asset('assets/images/Icon.png'),
            title: Text(
              'VeilNet Rift',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user.user?.email ?? ''),
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text('Subscriptions'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to dashboard
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              try {
                await supabase.auth.signOut();
              } on AuthException catch (e) {
                if (context.mounted) {
                  DialogManager.showDialog(context, e.message, DialogType.error);
                }
              } catch (e) {
                if (context.mounted) {
                  DialogManager.showDialog(context, e.toString(), DialogType.error);
                }
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'VeilNet Rift v1.0.0',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
