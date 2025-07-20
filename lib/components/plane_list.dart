import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/components/plane_search_card.dart';
import 'package:rift/providers/plane_provider.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:uuid/uuid.dart';

class PlaneList extends HookConsumerWidget {
  const PlaneList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planes = ref.watch(planesProvider);
    final regionFilter = ref.watch(regionFilterProvider);
    final nameFilter = ref.watch(planeNameFilterProvider);
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlaneSearchCard(),
        planes.when(
          data: (data) {
            final filteredPlanes =
                data.where((plane) {
                  return regionFilter.contains(plane.region) &&
                      plane.name.contains(nameFilter);
                }).toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredPlanes.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Text(
                      getFlagEmoji(filteredPlanes[index].region),
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(filteredPlanes[index].name),
                    subtitle: Text(filteredPlanes[index].subnet),
                    trailing: FilledButton(
                      onPressed:
                          veilNet.isBusy || veilNet.isConnected
                              ? null
                              : () {
                                connectToPlane(filteredPlanes[index]);
                              },
                      child: Text('Connect'),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
