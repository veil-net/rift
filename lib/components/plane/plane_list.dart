import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/plane/plane_list_tile.dart';
import 'package:rift/providers/plane_provider.dart';

class PlaneList extends HookConsumerWidget {
  const PlaneList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planes = ref.watch(planesProvider);
    final selectedRegions = ref.watch(selectedRegionsProvider);
    final planeSearchQuery = ref.watch(planeSearchQueryProvider);
    final planePrivacy = ref.watch(planePrivacyProvider);

    return planes.when(
      data: (data) {
        final filteredPlanes =
            data.where((plane) {
              return selectedRegions.contains(plane.region) &&
                  plane.name.contains(planeSearchQuery) &&
                  plane.public == !planePrivacy;
            }).toList();
        return Expanded(
          child: ListView.builder(
            itemCount: filteredPlanes.length,
            itemBuilder: (context, index) {
              return PlaneListTile(plane: filteredPlanes[index]);
            },
          ),
        );
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
