import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/veilnet_provider.dart';

class StatusCard extends HookConsumerWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilNet = ref.watch(veilnetProvider);
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading:
                  veilNet.isBusy
                      ? const CircularProgressIndicator()
                      : veilNet.isConnected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.warning, color: Colors.red),
              title: Text(
                veilNet.isBusy
                    ? veilNet.shouldConnect
                        ? 'Connecting...'
                        : 'Disconnecting...'
                    : veilNet.isConnected
                    ? 'Connected to ${veilNet.conflux?.plane}'
                    : 'Disconnected',
                style: TextStyle(
                  color:
                      veilNet.isBusy
                          ? Colors.grey
                          : veilNet.isConnected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.red,
                ),
              ),
              subtitle:
                  veilNet.isBusy
                      ? LinearProgressIndicator()
                      : veilNet.isConnected
                      ? Text(veilNet.conflux?.cidr ?? '')
                      : Text('Please connect to a plane'),
              trailing:
                  veilNet.isBusy
                      ? null
                      : veilNet.isConnected
                      ? IconButton(
                        onPressed: () async {
                          await ref.read(veilnetProvider.notifier).disconnect();
                        },
                        icon: Icon(Icons.power_settings_new, color: Colors.red),
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
