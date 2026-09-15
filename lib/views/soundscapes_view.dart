import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/focus_sphere_viewmodel.dart';
import '../ui/zenorix_palette.dart';

class SoundscapesView extends StatelessWidget {
  const SoundscapesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FocusSphereViewModel>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.soundscapes.length,
      itemBuilder: (context, idx) {
        final sound = vm.soundscapes[idx];
        final isCurrent = sound == vm.activeSoundscape;

        return Card(
          color: ZenorixPalette.cardBg,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isCurrent ? ZenorixPalette.sphereElectricBlue : Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Icon(
              Icons.graphic_eq,
              color: isCurrent ? ZenorixPalette.sphereElectricBlue : ZenorixPalette.textDim,
            ),
            title: Text(sound, style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: isCurrent
                ? const Icon(Icons.check_circle, color: ZenorixPalette.sphereElectricBlue)
                : TextButton(
                    onPressed: () => vm.setSoundscape(sound),
                    child: const Text('Activate'),
                  ),
          ),
        );
      },
    );
  }
}
