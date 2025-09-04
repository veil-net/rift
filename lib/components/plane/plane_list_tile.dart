import 'package:country_flags/country_flags.dart';
import 'package:rift/models/plane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:uuid/uuid.dart';

class PlaneListTile extends HookConsumerWidget {
  final Plane plane;
  const PlaneListTile({super.key, required this.plane});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    ref.watch(veilnetNotiferProvider);
    final veilnetNotifer = ref.watch(veilnetNotiferProvider.notifier);
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      builder:
          (context, value, child) => Opacity(
            opacity: value,
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: CountryFlag.fromCountryCode(
                      plane.region.toUpperCase(),
                    ),
                    title: Text(
                      plane.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: FilledButton(
                      onPressed:
                          plane.portals <= 0 ||
                                  veilnetNotifer.isBusy() ||
                                  veilnetNotifer.isConnected()
                              ? null
                              : () async {
                                await veilnetNotifer.connect(
                                  Uuid().v4(),
                                  plane,
                                );
                              },
                      child: const Text('Connect'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    child: Icon(
                      isExpanded.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child:
                        isExpanded.value
                            ? Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.cyclone,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  title: Text(
                                    'Portals',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                  trailing: Text(plane.portals.toString()),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.lan,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  title: Text(
                                    'Subnet',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                  trailing: Text(plane.subnet),
                                  dense: true,
                                ),
                              ],
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
