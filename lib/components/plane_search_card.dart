import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/plane_provider.dart';

class PlaneSearchCard extends HookConsumerWidget {
  const PlaneSearchCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regions = ref.watch(regionProvider);
    final regionFilter = ref.watch(regionFilterProvider);

    final planeNameTextController = useTextEditingController();

    String getFlagEmoji(String region) {
      if (region.length != 2) return '';
      final base = 0x1F1E6;
      final chars = region.toUpperCase().codeUnits;
      return String.fromCharCodes([
        base + (chars[0] - 0x41),
        base + (chars[1] - 0x41),
      ]);
    }

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Plane Name',
                      hintText: 'Search for a plane',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          planeNameTextController.clear();
                          ref.read(planeNameFilterProvider.notifier).state = '';
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                    controller: planeNameTextController,
                    onChanged: (value) {
                      ref.read(planeNameFilterProvider.notifier).state = value;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.invalidate(planesProvider);
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: regions.when(
                data:
                    (data) =>
                        data
                            .map(
                              (region) => FilterChip(
                                label: Text(getFlagEmoji(region)),
                                selected: regionFilter.contains(region),
                                onSelected: (value) {
                                  ref
                                      .read(regionFilterProvider.notifier)
                                      .state = ref
                                              .read(regionFilterProvider)
                                              .contains(region)
                                          ? ref
                                              .read(regionFilterProvider)
                                              .where((r) => r != region)
                                              .toList()
                                          : [
                                            ...ref.read(regionFilterProvider),
                                            region,
                                          ];
                                },
                              ),
                            )
                            .toList(),
                error: (error, stackTrace) => [],
                loading: () => [],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Public'),
                Switch(
                  value: ref.watch(planeVisibilityProvider),
                  onChanged: (value) {
                    ref.read(planeVisibilityProvider.notifier).state = value;
                  },
                ),
                Text('Private'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
