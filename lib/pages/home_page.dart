import 'package:rift/components/plane/plane_list_tile.dart';
import 'package:rift/components/profile_card.dart';
import 'package:rift/components/status_card.dart';
import 'package:rift/providers/plane_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planes = ref.watch(planesProvider);
    final isPublic = useState(true);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width * 0.5 - 16,
                    ),
                    child: ProfileCard(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width * 0.5 - 16,
                    ),
                    child: StatusCard(),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: [isPublic.value, !isPublic.value],
                    onPressed: (index) => isPublic.value = index == 0,
                    borderRadius: BorderRadius.circular(16),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [Icon(Icons.public), Text('Public')],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [Icon(Icons.lock), Text('Private')],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: planes.when(
                data: (planes) {
                  final filteredPlanes = isPublic.value
                      ? planes.where((plane) => plane.public).toList()
                      : planes.where((plane) => !plane.public).toList();
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filteredPlanes
                        .map(
                          (plane) => ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.width
                                  : MediaQuery.of(context).size.width * 0.5 - 16,
                            ),
                            child: PlaneListTile(plane: plane),
                          ),
                        )
                        .toList(),
                  );
                },
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
