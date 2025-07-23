import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/providers/plane_provider.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:uuid/uuid.dart';

class PlaneListTile extends HookConsumerWidget {
  final Plane plane;
  const PlaneListTile({super.key, required this.plane});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilNet = ref.watch(veilnetProvider);
    final veilNetNotifier = ref.watch(veilnetProvider.notifier);

    String getFlagEmoji(String region) {
      if (region.length != 2) return '';
      final base = 0x1F1E6;
      final chars = region.toUpperCase().codeUnits;
      return String.fromCharCodes([
        base + (chars[0] - 0x41),
        base + (chars[1] - 0x41),
      ]);
    }

    Future<void> connectToPlane(Plane plane) async {
      try {
        await veilNetNotifier.connect(Uuid().v4(), plane.name, plane.public);
      } catch (e) {
        if (context.mounted) {
          DialogManager.showDialog(context, e.toString(), DialogType.error);
        }
      }
    }

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(milliseconds: 250),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * 100, 0),
          child: Card(
            elevation: 5,
            child: ListTile(
              leading: Text(
                getFlagEmoji(plane.region),
                style: TextStyle(fontSize: 24),
              ),
              title: Text(
                plane.name,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              subtitle: Text(
                plane.subnet,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              trailing: FilledButton(
                onPressed:
                    veilNet.isBusy || veilNet.isConnected || plane.portals == 0
                        ? null
                        : () {
                          connectToPlane(plane);
                        },
                child: Text('Connect'),
              ),
            ),
          ),
        );
      },
    );
  }
}