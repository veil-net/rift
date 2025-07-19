import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/plane_provider.dart';

class RegionFilter extends HookConsumerWidget {
  const RegionFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regions = ref.watch(regionFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var region in regions)
            FilterChip(
              label: Text(region),
              selected: true,
              onSelected: (selected) {
                if (selected) {
                  if (!regions.contains(region)) {
                    ref.read(regionFilterProvider.notifier).state = [
                      ...regions,
                      region,
                    ];
                  }
                } else {
                  if (regions.contains(region)) {
                    ref.read(regionFilterProvider.notifier).state =
                        regions.where((r) => r != region).toList();
                  }
                }
              },
            ),
        ],
      ),
    );
  }
}
