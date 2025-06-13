import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/portal_provider.dart';

import '../providers/domain_provider.dart';
import '../providers/rift_provider.dart';

class DomainSearchBar extends HookConsumerWidget {
  const DomainSearchBar({
    super.key,
    required this.searchController,
    required this.selectedSegment,
  });

  final TextEditingController searchController;
  final ValueNotifier<int> selectedSegment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              ref.invalidate(domainProvider(true));
              ref.invalidate(domainProvider(false));
              ref.invalidate(portalProvider(true));
              ref.invalidate(portalProvider(false));
              ref.invalidate(riftProvider(true));
              ref.invalidate(riftProvider(false));
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
