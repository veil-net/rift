import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/appbar.dart';
import 'package:rift/components/background.dart';
import 'package:rift/components/notification/notification_list.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: VeilNetAppBar(
        ),
        body: const NotificationList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}