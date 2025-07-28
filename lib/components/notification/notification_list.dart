import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/notification/notification_card.dart';
import 'package:rift/providers/notification_provider.dart';

class NotificationList extends HookConsumerWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);
    return notifications.when(
      data:
          (notifications) => ListView.builder(
            itemCount: notifications.length,
            itemBuilder:
                (context, index) =>
                    NotificationCard(notification: notifications[index]),
          ),
      error:
          (error, stackTrace) => const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Icon(Icons.error),
                Text('Failed to load notifications'),
              ],
            ),
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
