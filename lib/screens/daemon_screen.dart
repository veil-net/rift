import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/auth_guard.dart';
import 'package:rift/components/glass_card.dart';

import '../components/custom_appbar.dart';
import '../providers/veilnet_provider.dart';

class DaemonScreen extends HookConsumerWidget {
  const DaemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilnet = ref.watch(veilnetNotifierProvider);
    final scrollController = ScrollController();

    return AuthGuard(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Status and Controls
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Status Indicator
                    // Container(
                    //   width: 12,
                    //   height: 12,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: veilnet.isRunning ? Colors.green : Colors.red,
                    //   ),
                    // ),
                    // const SizedBox(width: 8),
                    // Text(
                    //   veilnet.isRunning ? 'Daemon Running' : 'Daemon Stopped',
                    //   style: Theme.of(context).textTheme.titleMedium,
                    // ),
                    // const Spacer(),
                    // // Control Buttons
                    // if (!veilnet.isRunning)
                    //   FilledButton.icon(
                    //     onPressed:
                    //         () => ref.read(veilnetNotifierProvider.notifier).startDaemon(),
                    //     icon: const Icon(Icons.play_arrow),
                    //     label: const Text('Start'),
                    //   )
                    // else
                    //   FilledButton.icon(
                    //     onPressed:
                    //         () => ref.read(veilnetNotifierProvider.notifier).stopDaemon(),
                    //     icon: const Icon(Icons.stop),
                    //     label: const Text('Stop'),
                    //     style: FilledButton.styleFrom(
                    //       backgroundColor: Theme.of(context).colorScheme.error,
                    //     ),
                    //   ),
                    // const SizedBox(width: 8),
                    IconButton(
                      onPressed:
                          () => ref.read(veilnetNotifierProvider.notifier).clearLogs(),
                      icon: const Icon(Icons.clear_all),
                      tooltip: 'Clear Logs',
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: veilnet.logs.join('\n')));
                      },
                      icon: const Icon(Icons.code),
                      tooltip: 'Copy Logs',
                    ),
                  ],
                ),
              ),
              // Log Viewer
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlassCard(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: veilnet.logs.length,
                        itemBuilder: (context, index) {
                          final log = veilnet.logs[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(log),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
