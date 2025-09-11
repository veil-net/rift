import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/plane_provider.dart';
import 'package:rift/providers/user_provider.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class PlaneListTile extends HookConsumerWidget {
  final Plane plane;
  const PlaneListTile({super.key, required this.plane});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilNet = ref.watch(veilnetProvider);
    final veilNetNotifier = ref.watch(veilnetProvider.notifier);
    final api = ref.watch(apiProvider);
    final isLoading = useState(false);

    String getFlagEmoji(String region) {
      if (region.length != 2) return '';
      final base = 0x1F1E6;
      final chars = region.toUpperCase().codeUnits;
      return String.fromCharCodes([
        base + (chars[0] - 0x41),
        base + (chars[1] - 0x41),
      ]);
    }

    Future<void> connectToPlane(Plane plane) async {
      final userProfile = await ref.read(userProfileProvider.future);
      final serviceTier = await ref.read(userServiceTierProvider.future);
      if (userProfile.mp <= 0 && serviceTier == 0) {
        if (context.mounted) {
          showAdaptiveDialog(
            context: context,
            builder: (context) => AlertDialog(
              alignment: Alignment.center,
              content: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.error, color: Colors.white),
                        ),
                        Text(
                          'Insufficient MP',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    Text(
                      'You do not have enough MP. To continue, please choose one of the following options.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              actions: [
                FilledButton(
                  onPressed: isLoading.value ? null : () {
                    isLoading.value = true;
                    final url = Uri.parse(
                      'https://www.veilnet.org/docs/self-host-via-docker/',
                    );
                    launchUrl(url);
                    isLoading.value = false;
                    context.pop();
                  },
                  child: isLoading.value ? const CircularProgressIndicator() : Text('Self-host'),
                ),
                FilledButton(
                  onPressed: isLoading.value ? null : () async {
                    isLoading.value = true;
                    final currentServiceTier = await ref.read(
                      userServiceTierProvider.future,
                    );
                    final upgradedServiceTier = currentServiceTier + 1;
                    try {
                      final response = await api.get(
                        '/stripe/subscribe/$upgradedServiceTier',
                      );
                      final checkoutSession = response.data;
                      launchUrl(Uri.parse(checkoutSession['url']));
                      isLoading.value = false;
                      if (context.mounted) {
                        context.pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        DialogManager.showDialog(
                          context,
                          e.toString(),
                          DialogType.error,
                        );
                      }
                    }
                  },
                  child: isLoading.value ? const CircularProgressIndicator() : Text('Upgrade'),
                ),
              ],
            ),
          );
        }
        return;
      }
      try {
        await veilNetNotifier.connect(Uuid().v4(), plane.name, plane.public);
      } catch (e) {
        if (context.mounted) {
          DialogManager.showDialog(context, e.toString(), DialogType.error);
        }
      }
    }

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(milliseconds: 250),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * 100, 0),
          child: Card(
            elevation: 5,
            child: ListTile(
              leading: Text(
                getFlagEmoji(plane.region),
                style: TextStyle(fontSize: 24),
              ),
              title: Text(
                plane.name,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              subtitle: Text(
                plane.subnet,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              trailing: FilledButton(
                onPressed:
                    veilNet.isBusy || veilNet.isConnected || plane.portals == 0
                    ? null
                    : () {
                        connectToPlane(plane);
                      },
                child: Text('Connect'),
              ),
            ),
          ),
        );
      },
    );
  }
}
