import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/theme_provider.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeProviderProvider);
    final themeNotifier = ref.watch(themeProviderProvider.notifier);
    final currentTheme = themeAsync.value ?? ThemeMode.system;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode, size: 16),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode, size: 16),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      label: Text('Auto'),
                      icon: Icon(Icons.auto_mode, size: 16),
                    ),
                  ],
                  selected: {currentTheme},
                  onSelectionChanged: (Set<ThemeMode> selection) {
                    themeNotifier.setTheme(selection.first);
                  },
                ),
          ],
        ),
      ),
    );
  }
}
