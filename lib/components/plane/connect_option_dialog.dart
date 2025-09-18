import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/providers/api_provider.dart';
import 'package:rift/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectOptionDialog extends HookConsumerWidget {
  const ConnectOptionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final api = ref.watch(apiProvider);
    return AlertDialog(
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
          onPressed: isLoading.value
              ? null
              : () {
                  isLoading.value = true;
                  final url = Uri.parse(
                    'https://www.veilnet.org/docs/self-host-via-docker/',
                  );
                  launchUrl(url);
                  isLoading.value = false;
                  context.pop();
                },
          child: isLoading.value
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: const CircularProgressIndicator(),
                )
              : Text('Self-host'),
        ),
        FilledButton(
          onPressed: isLoading.value
              ? null
              : () async {
                  isLoading.value = true;
                  final currentServiceTier = await ref.read(
                    userServiceTierProvider.future,
                  );
                  if (currentServiceTier == 2) {
                    return;
                  }
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
          child: isLoading.value
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: const CircularProgressIndicator(),
                )
              : Text('Upgrade'),
        ),
      ],
    );
  }
}
