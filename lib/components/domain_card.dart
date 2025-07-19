import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/plane_provider.dart';
import 'package:rift/providers/veilnet_provider.dart';
import 'package:uuid/uuid.dart';

import 'dialog.dart';
import 'glass_card.dart';

class PlaneCard extends HookConsumerWidget {
  final Plane plane;
  const PlaneCard({super.key, required this.plane});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilnet = ref.watch(veilnetProvider);
    final veilnetNotifier = ref.watch(veilnetProvider.notifier);
    final isBusy = useState(false);

    String countryCodeToFlagEmoji(String countryCode) {
      if (countryCode.length != 2) return '';
      final base = 0x1F1E6;
      final chars = countryCode.toUpperCase().codeUnits;
      return String.fromCharCodes([
        base + (chars[0] - 0x41),
        base + (chars[1] - 0x41),
      ]);
    }

    Future<void> connect() async {
      try {
        isBusy.value = true;

        await veilnetNotifier.connect(
          Uuid().v4(),
          plane.name,
        );
      } catch (e) {
        if (context.mounted) {
          DialogManager.showDialog(
            context,
            'Failed to connect to domain: $e',
            DialogType.error,
          );
        }
      } finally {
        isBusy.value = false;
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: Text(
                  countryCodeToFlagEmoji(plane.region),
                  style: TextStyle(fontSize: 24),
                ),
                title: Text(
                  plane.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  plane.subnet,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                trailing: FilledButton.icon(
                  onPressed:
                      veilnet.isConnected || veilnet.isBusy || isBusy.value
                          ? null
                          : () async {
                            await connect();
                          },
                  icon: Icon(Icons.power_settings_new),
                  label:
                      veilnet.isBusy || isBusy.value
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: const CircularProgressIndicator.adaptive(),
                          )
                          : const Text('Connect'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
