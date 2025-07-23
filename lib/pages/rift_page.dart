import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/appbar.dart';
import 'package:rift/components/background.dart';
import 'package:rift/components/conflux/conflux_card.dart';
import 'package:rift/providers/conflux_provider.dart';

class RiftPage extends HookConsumerWidget {
  const RiftPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conflux = ref.watch(confluxesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isPortrait = constraints.maxWidth < constraints.maxHeight;
        return AnimatedBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: VeilNetAppBar(),
            body: conflux.when(
              data: (data) {
                final rifts =
                    data.where((conflux) => conflux.portal == false).toList();
                return Wrap(
                  children:
                      rifts
                          .map(
                            (conflux) => ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    isPortrait
                                        ? constraints.maxWidth
                                        : constraints.maxWidth / 2,
                              ),
                              child: ConfluxCard(conflux: conflux),
                            ),
                          )
                          .toList(),
                );
              },
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.pop();
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
        );
      },
    );
  }
}
