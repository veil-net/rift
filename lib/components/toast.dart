import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

void showToast(BuildContext context, String message, ToastType type) {
  final messager = ScaffoldMessenger.of(context);
  messager.showMaterialBanner(
    MaterialBanner(
      backgroundColor: switch (type) {
        ToastType.success => Colors.green,
        ToastType.error => Colors.red,
        ToastType.warning => Colors.yellow,
        ToastType.info => Colors.blue,
      },
      content: Text(message, style: TextStyle(color: Colors.white)),
      actions: [
        TextButton(
          onPressed: () {
            messager.clearMaterialBanners();
          },
          child: Text('Dismiss', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
  Future.delayed(const Duration(seconds: 3), () {
    messager.clearMaterialBanners();
  });
}
