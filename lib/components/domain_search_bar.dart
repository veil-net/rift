import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/plane_provider.dart';

class DomainSearchBar extends HookConsumerWidget {
  const DomainSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final planeNameFilter = ref.watch(planeNameFilterProvider);

    // Sync controller value to state
    useEffect(() {
      searchController.text = planeNameFilter;
      return null;
    }, [planeNameFilter]);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search domains...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface.withAlpha(100),
              ),
              controller: searchController,
              onChanged: (value) {
                // Update state when text changes
                ref.read(planeNameFilterProvider.notifier).state = value;
              },
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              ref.invalidate(planesProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
