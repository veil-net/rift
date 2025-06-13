import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/auth_guard.dart';
import '../components/custom_appbar.dart';
import '../components/glass_card.dart';
import '../components/veilnet_status_card.dart';
import '../components/domain_card.dart';
import '../components/domain_region_filter.dart';
import '../components/domain_search_bar.dart';
import '../providers/domain_provider.dart';
import '../providers/portal_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicDomains = ref.watch(domainProvider(true));
    final privateDomains = ref.watch(domainProvider(false));
    final pageController = usePageController();
    final selectedSegment = useState(0);
    final searchController = useTextEditingController();
    useListenable(searchController);
    final selectedRegions = useState<Set<String>>({});

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          ref.invalidate(domainProvider(true));
          ref.invalidate(domainProvider(false));
          ref.invalidate(portalProvider(true));
          ref.invalidate(portalProvider(false));
        }
      });

      return null;
    }, [ModalRoute.of(context)]);

    useEffect(() {
      final regions =
          selectedSegment.value == 0
              ? publicDomains.value
                      ?.map((d) => d.region.toUpperCase())
                      .toSet() ??
                  {}
              : privateDomains.value
                      ?.map((d) => d.region.toUpperCase())
                      .toSet() ??
                  {};
      if (regions.isNotEmpty) {
        selectedRegions.value = regions;
      }
      return null;
    }, [publicDomains.value, privateDomains.value, selectedSegment.value]);

    return AuthGuard(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: const CustomAppBar(),
          ),
          body: Center(
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
                        DomainSearchBar(
                          searchController: searchController,
                          selectedSegment: selectedSegment,
                        ),
                        const SizedBox(height: 8),
                        RegionFilter(
                          selectedSegment: selectedSegment,
                          publicDomains: publicDomains,
                          privateDomains: privateDomains,
                          selectedRegions: selectedRegions,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Public',
                              style: TextStyle(
                                color:
                                    selectedSegment.value == 0
                                        ? Theme.of(context).colorScheme.primary
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
                                  duration: const Duration(milliseconds: 300),
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
                                        ? Theme.of(context).colorScheme.primary
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
                                child: publicDomains.when(
                                  data:
                                      (data) => ListView.builder(
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final domain = data[index];
                                          if ((searchController.text.isEmpty ||
                                                  data[index].name
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController.text
                                                            .toLowerCase(),
                                                      )) &&
                                              selectedRegions.value.contains(
                                                domain.region.toUpperCase(),
                                              )) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: DomainCard(
                                                domain: data[index],
                                                public: true,
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                  error:
                                      (error, stack) => Text(error.toString()),
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
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
                                child: privateDomains.when(
                                  data:
                                      (data) => ListView.builder(
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final domain = data[index];
                                          if ((searchController.text.isEmpty ||
                                                  data[index].name
                                                      .toLowerCase()
                                                      .contains(
                                                        searchController.text
                                                            .toLowerCase(),
                                                      )) &&
                                              selectedRegions.value.contains(
                                                domain.region.toUpperCase(),
                                              )) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: DomainCard(
                                                domain: data[index],
                                                public: false,
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                  error:
                                      (error, stack) => Text(error.toString()),
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
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
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).colorScheme.surface.withAlpha(100),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SizedBox(
          //         width: 50,
          //         child: Text(
          //           'Public',
          //           textAlign: TextAlign.right,
          //           style: TextStyle(
          //             color:
          //                 selectedSegment.value == 0
          //                     ? Theme.of(context).colorScheme.primary
          //                     : Colors.white,
          //           ),
          //         ),
          //       ),
          //       Switch(
          //         value: selectedSegment.value == 1,
          //         onChanged: (bool isPrivate) {
          //           final newIndex = isPrivate ? 1 : 0;
          //           selectedSegment.value = newIndex;
          //           pageController.animateToPage(
          //             newIndex,
          //             duration: const Duration(milliseconds: 300),
          //             curve: Curves.easeInOut,
          //           );
          //         },
          //         activeColor: Theme.of(context).colorScheme.secondary,
          //         inactiveThumbColor: Theme.of(context).colorScheme.secondary,
          //       ),
          //       SizedBox(
          //         width: 50,
          //         child: Text(
          //           'Private',
          //           textAlign: TextAlign.left,
          //           style: TextStyle(
          //             color:
          //                 selectedSegment.value == 1
          //                     ? Theme.of(context).colorScheme.primary
          //                     : Colors.white,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
