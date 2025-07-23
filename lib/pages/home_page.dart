import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/appbar.dart';
import 'package:rift/components/background.dart';
import 'package:rift/components/plane/plane_card.dart';
import 'package:rift/components/profile_card.dart';
import 'package:rift/components/status_card.dart';
import 'package:rift/providers/veilnet_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPortrait = constraints.maxWidth < constraints.maxHeight;
        return AnimatedBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: VeilNetAppBar(),
            body: SafeArea(
              child: Center(
                child:
                    isPortrait
                        ? Column(
                          children: [
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              curve: Curves.easeInOut,
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          isPortrait
                                              ? constraints.maxWidth
                                              : constraints.maxWidth * 0.5,
                                    ),
                                    child: ProfileCard(),
                                  ),
                                );
                              },
                            ),
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              curve: Curves.easeInOut,
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          isPortrait
                                              ? constraints.maxWidth
                                              : constraints.maxWidth * 0.5,
                                    ),
                                    child: StatusCard(),
                                  ),
                                );
                              },
                            ),
                            Expanded(
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: 1),
                                curve: Curves.easeInOut,
                                duration: const Duration(seconds: 1),
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            isPortrait
                                                ? constraints.maxWidth
                                                : constraints.maxWidth * 0.5,
                                      ),
                                      child: PlaneCard(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                        : Row(
                          children: [
                            Column(
                              children: [
                                TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: 1),
                                  curve: Curves.easeInOut,
                                  duration: const Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              isPortrait
                                                  ? constraints.maxWidth
                                                  : constraints.maxWidth * 0.5,
                                        ),
                                        child: ProfileCard(),
                                      ),
                                    );
                                  },
                                ),
                                TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: 1),
                                  curve: Curves.easeInOut,
                                  duration: const Duration(seconds: 1),
                                  builder: (context, value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              isPortrait
                                                  ? constraints.maxWidth
                                                  : constraints.maxWidth * 0.5,
                                        ),
                                        child: StatusCard(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0, end: 1),
                              curve: Curves.easeInOut,
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          isPortrait
                                              ? constraints.maxWidth
                                              : constraints.maxWidth * 0.5,
                                      maxHeight: constraints.maxHeight,
                                    ),
                                    child: PlaneCard(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogCard extends HookConsumerWidget {
  const LogCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.terminal,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Logs',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      logs.isEmpty ? 'No logs available' : logs.join('\n'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
