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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search domains...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface.withAlpha(100),
              ),
              controller: searchController,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              ref.invalidate(publicDomainProvider);
              ref.invalidate(privateDomainProvider);
              ref.invalidate(publicPortalProvider);
              ref.invalidate(privatePortalProvider);
              ref.invalidate(publicPortalSessionsProvider);
              ref.invalidate(privatePortalSessionsProvider);
              ref.invalidate(publicRiftProvider);
              ref.invalidate(privateRiftProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
