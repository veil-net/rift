import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/plane/plane_filter_card.dart';
import 'package:rift/components/plane/plane_list_tile.dart';
import 'package:rift/components/profile_card.dart';
import 'package:rift/components/status_card.dart';
import 'package:rift/providers/plane_provider.dart';
import 'package:rift/providers/publicity_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planes = ref.watch(planesProvider);
    final isPublic = ref.watch(publicityProvider);
    final planeQuery = ref.watch(planeQueryProvider);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 4,
                runSpacing: 4,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width * 0.5 - 8,
                    ),
                    child: ProfileCard(),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width * 0.5 - 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StatusCard(),
                        PlaneFilterCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: planes.when(
                data: (planes) {
                  planes =
                      isPublic
                          ? planes.where((plane) => plane.public).toList()
                          : planes.where((plane) => !plane.public).toList();
                  planes = planes.where((plane) => plane.name.contains(planeQuery)).toList();
                  return Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 4,
                    runSpacing: 4,
                    children:
                        planes
                            .map(
                              (plane) => ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.width
                                          : MediaQuery.of(context).size.width *
                                                  0.5 -
                                              8,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(publicityProvider.notifier).toggle();
        },
        child: isPublic ? Icon(Icons.public) : Icon(Icons.public_off),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              context.push('/home');
              break;
            case 1:
              context.push('/settings');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
