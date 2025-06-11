import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/veilnet_provider.dart';

class TrayWrapper extends StatefulHookConsumerWidget {
  final Widget child;
  const TrayWrapper({super.key, required this.child});

  @override
  ConsumerState<TrayWrapper> createState() => _TrayWrapperState();
}

class _TrayWrapperState extends ConsumerState<TrayWrapper>
    with TrayListener, WindowListener {
  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
    windowManager.addListener(this);
    init();
  }

  Future<void> init() async {
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/images/icon.ico' : 'assets/images/icon.png',
    );
    await trayManager.setToolTip('Veilnet Rift');
    await trayManager.setContextMenu(
      Menu(
        items: [
          MenuItem(key: 'show', label: 'Show'),
          MenuItem(key: 'exit', label: 'Exit'),
        ],
      ),
    );
    await ref.read(veilnetNotifierProvider.notifier).startDaemon();
  }

  @override
  void onTrayIconMouseDown() async {
    if (!await windowManager.isVisible()) {
      await windowManager.show();
      await windowManager.focus();
    }
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem item) async {
    switch (item.key) {
      case 'show':
        await windowManager.show();
        await windowManager.focus();
        break;
      case 'exit':
        await trayManager.destroy();
        await windowManager.destroy();
        await ref.read(veilnetNotifierProvider.notifier).stopDaemon();
        break;
    }
  }

  @override
  void onWindowClose() async {
    await windowManager.hide(); // hide to tray
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
