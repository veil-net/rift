import 'package:flutter/material.dart';
import 'package:rift/providers/pref_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeProvider extends _$ThemeProvider {
  @override
  Future<ThemeMode> build() async {
    final pref = await ref.watch(prefProvider.future);
    final theme = pref.getString('theme');
    if (theme == 'system') {
      return ThemeMode.system;
    } else if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'dark') {
      return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode theme) async {
    final pref = await ref.watch(prefProvider.future);
    await pref.setString('theme', theme.name);
    ref.invalidateSelf();
  }

  Future<void> toggleTheme() async {
    final pref = await ref.watch(prefProvider.future);
    final theme = pref.getString('theme');
    if (theme == 'system') {
      await pref.setString('theme', 'light');
    } else if (theme == 'light') {
      await pref.setString('theme', 'dark');
    }
    ref.invalidateSelf();
  }
}
