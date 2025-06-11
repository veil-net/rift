import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/domain_provider.dart';

class RegionFilter extends StatelessWidget {
  const RegionFilter({
    super.key,
    required this.selectedSegment,
    required this.publicDomains,
    required this.privateDomains,
    required this.selectedRegions,
  });

  final ValueNotifier<int> selectedSegment;
  final AsyncValue<List<Domain>> publicDomains;
  final AsyncValue<List<Domain>> privateDomains;
  final ValueNotifier<Set<String>> selectedRegions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            (selectedSegment.value == 0
                    ? publicDomains.value
                            ?.map((d) => d.region.toUpperCase())
                            .toSet()
                            .toList() ??
                        []
                    : privateDomains.value
                            ?.map((d) => d.region.toUpperCase())
                            .toSet()
                            .toList() ??
                        [])
                .map((region) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FilterChip(
                      label: Text(region),
                      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(100),
                      selectedColor: Theme.of(context).colorScheme.surface.withAlpha(100),
                      selected: selectedRegions.value.contains(region),
                      onSelected: (selected) {
                        final newSelection = Set<String>.from(
                          selectedRegions.value,
                        );
                        if (selected) {
                          newSelection.add(region);
                        } else {
                          newSelection.remove(region);
                        }
                        selectedRegions.value = newSelection;
                      },
                    ),
                  );
                })
                .toList(),
      ),
    );
  }
}