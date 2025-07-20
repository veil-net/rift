import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DialogType { info, warning, success, error }

class DialogManager {
  static void showDialog(
    BuildContext context,
    String message,
    DialogType type,
  ) {
    final title = switch (type) {
      DialogType.info => Text(
        'Info',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Colors.blue),
      ),
      DialogType.warning => Text(
        'Warning',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Colors.yellow),
      ),
      DialogType.success => Text(
        'Success',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Colors.green),
      ),
      DialogType.error => Text(
        'Error',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Colors.red),
      ),
    };

    final icon = switch (type) {
      DialogType.info => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.info, color: Colors.white),
      ),
      DialogType.warning => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.warning, color: Colors.white),
      ),
      DialogType.success => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.check_circle, color: Colors.white),
      ),
      DialogType.error => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.error, color: Colors.white),
      ),
    };

    showAdaptiveDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            alignment: Alignment.center,
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [icon, const SizedBox(width: 16), title],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            actions: [
              if (type == DialogType.error)
                FilledButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message));
                  },
                  child: Text('Copy'),
                ),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }
}
