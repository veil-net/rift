import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/veilnet_provider.dart';

class StatusCard extends HookConsumerWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilnet = ref.watch(veilnetNotiferProvider);
    final veilnetNotifer = ref.watch(veilnetNotiferProvider.notifier);
    final shouldVeilNetConnect = ref.watch(shouldVeilNetConnectProvider);

    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: veilnet.when(
          data: (data) => veilnetNotifer.isBusy()
              ? const CircularProgressIndicator()
              : veilnetNotifer.isConnected()
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                )
              : Icon(
                  Icons.power_settings_new,
                  color: Theme.of(context).colorScheme.error,
                ),
          error: (error, stackTrace) =>
              Icon(Icons.error, color: Theme.of(context).colorScheme.error),
          loading: () => const CircularProgressIndicator(),
        ),
        title: veilnet.when(
          data: (data) => veilnetNotifer.isBusy()
              ? shouldVeilNetConnect
                  ? const Text('Connecting...')
                  : const Text('Diconnecting...')
              : veilnetNotifer.isConnected()
              ? Text(
                  'Connected to ${data?.region}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : Text(
                  'Disconnected',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
          error: (error, stackTrace) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Theme.of(context).colorScheme.error),
              Expanded(
                child: Text(
                  '$error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          loading: () => const LinearProgressIndicator(),
        ),
        subtitle: veilnet.when(
          data: (data) => veilnetNotifer.isBusy()
              ? const LinearProgressIndicator()
              : veilnetNotifer.isConnected()
              ? data?.cidr != null
                    ? Text(
                        '${data?.cidr}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    : const LinearProgressIndicator()
              : Text(
                  'Select a plane to connect',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
          error: (error, stackTrace) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Theme.of(context).colorScheme.error),
              Expanded(
                child: Text(
                  '$error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          loading: () => const LinearProgressIndicator(),
        ),
        trailing: veilnet.when(
          data: (data) => veilnetNotifer.isConnected()
              ? IconButton(
                  onPressed: veilnetNotifer.isBusy()
                      ? null
                      : () => ref
                            .read(veilnetNotiferProvider.notifier)
                            .disconnect(),
                  icon: Icon(
                    Icons.power_settings_new,
                    color: veilnetNotifer.isBusy() ? Colors.grey : Colors.red,
                  ),
                )
              : null,
          error: (error, stackTrace) => null,
          loading: () => null,
        ),
      ),
    );
  }
}
