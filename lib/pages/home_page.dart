import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/appbar.dart';
import 'package:rift/components/background.dart';
import 'package:rift/components/plane_list.dart';
import 'package:rift/components/profile_card.dart';
import 'package:rift/components/status_card.dart';
import 'package:rift/providers/veilnet_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 8),
    );

    useEffect(() {
      animationController.repeat();
      return null;
    }, [animationController]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isPortrait = constraints.maxWidth < constraints.maxHeight;
        return AnimatedGradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: VeilNetAppBar(),
            body: Wrap(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        isPortrait
                            ? constraints.maxWidth
                            : constraints.maxWidth * 0.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileCard(),
                      StatusCard(),
                      if (Platform.isWindows) LogCard(),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        isPortrait
                            ? constraints.maxWidth
                            : constraints.maxWidth * 0.5,
                  ),
                  child: PlaneList(),
                ),
              ],
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
                    border: Border.all(),
                  ),
                  child: SelectableText(
                    logs.isEmpty ? 'No logs available' : logs.join('\n'),
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
