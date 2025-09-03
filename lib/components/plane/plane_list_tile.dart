import 'package:rift/models/plane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:uuid/uuid.dart';

class PlaneListTile extends HookConsumerWidget {
  final Plane plane;
  const PlaneListTile({super.key, required this.plane});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final veilnetNotifer = ref.watch(veilnetNotiferProvider.notifier);
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [CircleAvatar(child: Text(plane.region.toUpperCase()))],
            ),
            title: Text(
              plane.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            subtitle: Text(
              plane.subnet,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${plane.portals} portals'),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed:
                      plane.portals <= 0 ||
                              veilnetNotifer.isBusy() ||
                              veilnetNotifer.isConnected()
                          ? null
                          : () async {
                            await veilnetNotifer.connect(
                              Uuid().v4(),
                              plane,
                            );
                          },
                  child: const Text('Connect'),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Icon(
              isExpanded.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child:
                isExpanded.value
                    ? Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Subnet',
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Text(plane.subnet),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'Veil ID',
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Text(plane.veil_id),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'Veil Host',
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Text(plane.veil_host),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'Veil Port',
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Text(plane.veil_port.toString()),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'Created At',
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Text(plane.created_at.toLocal().toString()),
                          dense: true,
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
