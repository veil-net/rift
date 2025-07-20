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
    final planeVisibility = ref.watch(planeVisibilityProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlaneSearchCard(),
        planes.when(
          data: (data) {
            final filteredPlanes =
                data.where((plane) {
                  return regionFilter.contains(plane.region) &&
                      plane.name.contains(nameFilter) &&
                      plane.public == !planeVisibility;
                }).toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredPlanes.length,
              itemBuilder: (context, index) {
                return PlaneCard(plane: filteredPlanes[index]);
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

class PlaneCard extends HookConsumerWidget {
  final Plane plane;
  const PlaneCard({super.key, required this.plane});

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
              title: Text(plane.name),
              subtitle: Text(plane.subnet),
              trailing: FilledButton(
                onPressed:
                    veilNet.isBusy ||
                            veilNet.isConnected ||
                            plane.portals == 0
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
