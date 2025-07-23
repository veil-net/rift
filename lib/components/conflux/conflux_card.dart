import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/providers/conflux_provider.dart';

class ConfluxCard extends HookConsumerWidget {
  final Conflux conflux;
  const ConfluxCard({super.key, required this.conflux});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Card(
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(
                        conflux.portal ? Icons.cyclone : Icons.electric_bolt,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      title: Text(
                        conflux.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        conflux.region,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      trailing: Text(
                        conflux.cidr ?? 'Offline',
                        style: TextStyle(
                          color:
                              conflux.cidr != null
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Signature',
                        border: OutlineInputBorder(),
                        isDense: true,
                        suffixIcon:
                            conflux.signature != null
                                ? IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: conflux.signature!),
                                    );
                                  },
                                  icon: Icon(Icons.copy),
                                )
                                : null,
                      ),
                      controller: TextEditingController(
                        text: conflux.signature ?? 'Offline',
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Created At',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            controller: TextEditingController(
                              text:
                                  "${conflux.created_at.toLocal().hour}:${conflux.created_at.toLocal().minute} ${conflux.created_at.toLocal().day}/${conflux.created_at.toLocal().month}/${conflux.created_at.toLocal().year}",
                            ),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Last Seen',
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            controller: TextEditingController(
                              text:
                                  "${conflux.last_seen.toLocal().hour}:${conflux.last_seen.toLocal().minute} ${conflux.last_seen.toLocal().day}/${conflux.last_seen.toLocal().month}/${conflux.last_seen.toLocal().year}",
                            ),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
