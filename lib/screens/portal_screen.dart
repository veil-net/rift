import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/auth_guard.dart';
import '../components/custom_appbar.dart';
import '../components/portal_card.dart';
import '../providers/portal_provider.dart';

class PortalScreen extends HookConsumerWidget {
  final bool isPublic;
  const PortalScreen({super.key, required this.isPublic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portals = ref.watch(portalProvider(isPublic));

    return AuthGuard(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: const CustomAppBar(),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isPublic ? 'Public Portals' : 'Private Portals',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Expanded(
                      child: portals.when(
                        data:
                            (data) => ListView.builder(
                              itemCount: data.length,
                              itemBuilder:
                                  (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: PortalCard(
                                      portal: data[index],
                                      isPublic: isPublic,
                                    ),
                                  ),
                            ),
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
