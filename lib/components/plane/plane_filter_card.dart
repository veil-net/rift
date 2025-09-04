import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/plane_provider.dart';

class PlaneFilterCard extends HookConsumerWidget {
  const PlaneFilterCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final planeQueryNotifier = ref.watch(planeQueryProvider.notifier);

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      builder:
          (context, value, child) => Opacity(
            opacity: value,
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchController,
                      onChanged:
                          (value) => planeQueryNotifier.setQuery(value),
                      decoration: InputDecoration(
                        hintText: 'Search by Plane Name',
                        prefixIcon: Icon(Icons.search),
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
