import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/auth_guard.dart';
import 'package:rift/components/custom_appbar.dart';
import 'package:rift/components/domain_card.dart';
import 'package:rift/components/domain_region_filter.dart';
import 'package:rift/components/domain_search_bar.dart';
import 'package:rift/components/glass_card.dart';
import 'package:rift/components/veilnet_status_card.dart';
import 'package:rift/providers/plane_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final selectedSegment = useState(0);
    final planes = ref.watch(planesProvider);
    final planeNameFilter = ref.watch(planeNameFilterProvider);
    final planeRegionFilter = ref.watch(regionFilterProvider);

    return AuthGuard(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: const CustomAppBar(),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          DaemonStatusCard(),
                          const SizedBox(height: 8),
                          GlassCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DomainSearchBar(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Public',
                                      style: TextStyle(
                                        color:
                                            selectedSegment.value == 0
                                                ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                                : Colors.white,
                                      ),
                                    ),
                                    Switch(
                                      value: selectedSegment.value == 1,
                                      onChanged: (bool isPrivate) {
                                        final newIndex = isPrivate ? 1 : 0;
                                        selectedSegment.value = newIndex;
                                        pageController.animateToPage(
                                          newIndex,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      activeColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                      inactiveThumbColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                    Text(
                                      'Private',
                                      style: TextStyle(
                                        color:
                                            selectedSegment.value == 1
                                                ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                                : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: PageView(
                              controller: pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    planes.when(
                                      data:
                                          (data) => ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              final domain = data[index];
                                              if ((planeNameFilter.isEmpty ||
                                                      data[index].name
                                                          .toLowerCase()
                                                          .contains(
                                                            planeNameFilter
                                                                .toLowerCase(),
                                                          )) &&
                                                  planeRegionFilter
                                                      .contains(
                                                        domain.region
                                                            .toUpperCase(),
                                                      )) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),
                                                  child: PlaneCard(
                                                    plane: data[index],
                                                  ),
                                                );
                                              }
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                      error:
                                          (error, stack) =>
                                              Text(error.toString()),
                                      loading:
                                          () => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    planes.when(
                                      data:
                                          (data) => ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              final domain = data[index];
                                              if ((planeNameFilter.isEmpty ||
                                                      data[index].name
                                                          .toLowerCase()
                                                          .contains(
                                                            planeNameFilter
                                                                .toLowerCase(),
                                                          )) &&
                                                  planeRegionFilter
                                                      .contains(
                                                        domain.region
                                                            .toUpperCase(),
                                                      )) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),
                                                  child: PlaneCard(
                                                    plane: data[index],
                                                  ),
                                                );
                                              }
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                      error:
                                          (error, stack) =>
                                              Text(error.toString()),
                                      loading:
                                          () => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        DaemonStatusCard(),
                        const SizedBox(height: 8),
                        GlassCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DomainSearchBar(),
                              const SizedBox(height: 8),
                              RegionFilter(),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Public',
                                    style: TextStyle(
                                      color:
                                          selectedSegment.value == 0
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                              : Colors.white,
                                    ),
                                  ),
                                  Switch(
                                    value: selectedSegment.value == 1,
                                    onChanged: (bool isPrivate) {
                                      final newIndex = isPrivate ? 1 : 0;
                                      selectedSegment.value = newIndex;
                                      pageController.animateToPage(
                                        newIndex,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    activeColor:
                                        Theme.of(context).colorScheme.secondary,
                                    inactiveThumbColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  Text(
                                    'Private',
                                    style: TextStyle(
                                      color:
                                          selectedSegment.value == 1
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                              : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: PageView(
                            controller: pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: planes.when(
                                        data:
                                            (data) => ListView.builder(
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                final domain = data[index];
                                                if ((planeNameFilter.isEmpty ||
                                                        data[index].name
                                                            .toLowerCase()
                                                            .contains(
                                                              planeNameFilter
                                                                  .toLowerCase(),
                                                            )) &&
                                                    planeRegionFilter
                                                        .contains(
                                                          domain.region
                                                              .toUpperCase(),
                                                        )) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 8,
                                                        ),
                                                    child: PlaneCard(
                                                      plane: data[index],
                                                    ),
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              },
                                            ),
                                        error:
                                            (error, stack) =>
                                                Text(error.toString()),
                                        loading:
                                            () => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: planes.when(
                                        data:
                                            (data) => ListView.builder(
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                final domain = data[index];
                                                if ((planeNameFilter.isEmpty ||
                                                        data[index].name
                                                            .toLowerCase()
                                                            .contains(
                                                              planeNameFilter
                                                                  .toLowerCase(),
                                                            )) &&
                                                    planeRegionFilter
                                                        .contains(
                                                          domain.region
                                                              .toUpperCase(),
                                                        )) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 8,
                                                        ),
                                                    child: PlaneCard(
                                                      plane: data[index],
                                                    ),
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              },
                                            ),
                                        error:
                                            (error, stack) =>
                                                Text(error.toString()),
                                        loading:
                                            () => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
