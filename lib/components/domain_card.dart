import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'dialog.dart';
import '../providers/api_provider.dart';
import '../providers/domain_provider.dart';
import '../providers/portal_provider.dart';
import '../providers/rift_provider.dart';
import '../providers/veilnet_provider.dart';
import 'glass_card.dart';

class DomainCard extends HookConsumerWidget {
  final Domain domain;
  final bool public;
  const DomainCard({super.key, required this.domain, required this.public});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilnet = ref.watch(veilnetNotifierProvider);
    final veilnetNotifier = ref.watch(veilnetNotifierProvider.notifier);
    final isBusy = useState(false);

    final rifts = ref.watch(riftProvider(public));

    final portals = ref.watch(portalProvider(public));

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
        final api = ref.read(apiProvider);
        final response = await api.get('/auth/token');
        final anchorToken = response.data['access_token'];

        await veilnetNotifier.connect(
          api.options.baseUrl,
          anchorToken,
          Uuid().v4(),
          domain.name,
          domain.region,
          public,
        );
        if (context.mounted) {
          DialogManager.showDialog(
            context,
            'Connected to domain',
            DialogType.success,
          );
        }
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
        ref.invalidate(riftProvider(public));
        ref.invalidate(portalProvider(public));
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
                  countryCodeToFlagEmoji(domain.region),
                  style: TextStyle(fontSize: 24),
                ),
                title: Text(
                  domain.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  domain.subnet,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                trailing: FilledButton.icon(
                  onPressed:
                      veilnet.isConnected || veilnet.isBusy
                          ? null
                          : () async {
                            try {
                              await connect();
                            } catch (e) {
                              if (context.mounted) {
                                DialogManager.showDialog(
                                  context,
                                  'Failed to connect to domain: $e',
                                  DialogType.error,
                                );
                              }
                            }
                          },
                  icon: Icon(Icons.power_settings_new),
                  label:
                      veilnet.isBusy
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: const CircularProgressIndicator.adaptive(),
                          )
                          : const Text('Connect'),
                ),
              ),
              const Divider(),
              Text(
                'You connections:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      child: ListTile(
                        leading: Icon(
                          Icons.cyclone,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        title: portals.when(
                          data:
                              (data) => Text(
                                '${data.where((portal) => portal.domain_id == domain.id && portal.online).length}/${data.where((portal) => portal.domain_id == domain.id).length}',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          error:
                              (error, stack) => Text(
                                'Error',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                          loading:
                              () => Text(
                                'Loading...',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                        ),
                        subtitle: Text(
                          'Portals',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GlassCard(
                      child: ListTile(
                        leading: Icon(
                          Icons.electric_bolt,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        title: rifts.when(
                          data:
                              (data) => Text(
                                '${data.where((rift) => rift.domain_id == domain.id && rift.online).length}/${data.where((rift) => rift.domain_id == domain.id).length}',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          error:
                              (error, stack) => Text(
                                'Error',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                          loading:
                              () => Text(
                                'Loading...',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                        ),
                        subtitle: Text(
                          'Rifts',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
