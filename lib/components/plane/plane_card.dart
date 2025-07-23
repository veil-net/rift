import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/plane/plane_list.dart';
import 'package:rift/components/plane/plane_search_bar.dart';

class PlaneCard extends HookConsumerWidget {
  const PlaneCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [PlaneSearchBar(), PlaneList()],
    );
  }
}
