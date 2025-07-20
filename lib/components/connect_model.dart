import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/plane_list.dart';
import 'package:rift/providers/veilnet_provider.dart';

class ConnectModel extends HookConsumerWidget {
  const ConnectModel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veilnet = ref.watch(veilnetProvider);
    final veilnetNotifier = ref.watch(veilnetProvider.notifier);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );

    final scaleAnimation = useAnimation(
      Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      ),
    );

    useEffect(() {
      if (!veilnet.isConnected) {
        animationController.repeat(reverse: true);
      } else {
        animationController.stop();
        animationController.reset();
      }
      return null;
    }, [animationController, veilnet.isConnected]);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: scaleAnimation,
          child: PhysicalModel(
            shape: BoxShape.circle,
            color:
                veilnet.isBusy
                    ? Theme.of(context).colorScheme.primary
                    : veilnet.isConnected
                    ? Colors.green
                    : Colors.red,
            elevation: 5,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: IconButton(
                  onPressed:
                      veilnet.isBusy
                          ? null
                          : veilnet.isConnected
                          ? () {
                            veilnetNotifier.disconnect();
                          }
                          : () {
                            showBottomSheet(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              context: context,
                              builder: (context) => PlaneList(),
                            );
                          },
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
