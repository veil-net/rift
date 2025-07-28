import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/notification_provider.dart';

class NotificationCard extends HookConsumerWidget {
  final VeilNetNotification notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                notification.title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              subtitle: Text(
                notification.type.toUpperCase(),
                style: TextStyle(
                  color: notification.type == 'info'
                      ? Colors.blue
                      : notification.type == 'warning'
                          ? Colors.yellow
                          : Colors.red,
                ),
              ),
              trailing: Text(
                '${notification.created_at.toLocal().hour}:${notification.created_at.toLocal().minute} - ${notification.created_at.toLocal().day}/${notification.created_at.toLocal().month}/${notification.created_at.toLocal().year}',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(notification.message, textAlign: TextAlign.justify),
            ),
          ],
        ),
      ),
    );
  }
}
