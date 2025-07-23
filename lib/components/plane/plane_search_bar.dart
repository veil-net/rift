import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/plane_provider.dart';

class PlaneSearchBar extends HookConsumerWidget {
  const PlaneSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regions = ref.watch(regionProvider);
    final selectedRegions = ref.watch(selectedRegionsProvider);

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
                          ref.read(planeSearchQueryProvider.notifier).state =
                              '';
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                    controller: planeNameTextController,
                    onChanged: (value) {
                      ref.read(planeSearchQueryProvider.notifier).state = value;
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
              spacing: 8,
              children: regions.when(
                data: (data) {
                  return data
                      .map(
                        (region) => FilterChip(
                          label: Text(getFlagEmoji(region)),
                          selected: selectedRegions.contains(region),
                          onSelected: (value) {
                            ref.read(selectedRegionsProvider.notifier).state =
                                ref
                                        .read(selectedRegionsProvider)
                                        .contains(region)
                                    ? ref
                                        .read(selectedRegionsProvider)
                                        .where((r) => r != region)
                                        .toList()
                                    : [
                                      ...ref.read(selectedRegionsProvider),
                                      region,
                                    ];
                          },
                        ),
                      )
                      .toList();
                },
                error:
                    (error, stackTrace) => [
                      Icon(
                        Icons.error,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      Text(error.toString()),
                    ],
                loading: () => [Expanded(child: LinearProgressIndicator())],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Public',
                  style: TextStyle(
                    color:
                        ref.watch(planePrivacyProvider)
                            ? Colors.grey
                            : Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Switch(
                  value: ref.watch(planePrivacyProvider),
                  onChanged: (value) {
                    ref.read(planePrivacyProvider.notifier).state = value;
                  },
                ),
                Text(
                  'Private',
                  style: TextStyle(
                    color:
                        ref.watch(planePrivacyProvider)
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
