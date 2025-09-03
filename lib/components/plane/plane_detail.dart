import 'package:rift/models/plane.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlaneDetail extends HookConsumerWidget {
  final Plane plane;
  const PlaneDetail({super.key, required this.plane});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 8,
                        children: [
                          CircleAvatar(child: Text(plane.region.toUpperCase())),
                          Expanded(
                            child: Text(
                              plane.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          plane.public ? const Icon(Icons.public) : const Icon(Icons.private_connectivity),
                        ],
                      ),
                      const Divider(),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              Text(
                                'Subnet',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(plane.subnet),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Veil ID',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(plane.veil_id),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Veil Host',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(plane.veil_host),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                'Veil Port',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(plane.veil_port.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('Created At', style: Theme.of(context).textTheme.bodyLarge),
                              Text(plane.created_at.toLocal().toString()),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
