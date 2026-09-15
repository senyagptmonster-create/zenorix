import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/focus_sphere_viewmodel.dart';
import '../ui/zenorix_palette.dart';

class SessionLogView extends StatelessWidget {
  const SessionLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FocusSphereViewModel>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.history.length,
      itemBuilder: (context, idx) {
        final item = vm.history[idx];
        return Card(
          color: ZenorixPalette.cardBg,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: ZenorixPalette.sphereNeonPurple.withValues(alpha: 0.3),
              child: const Icon(Icons.timer, color: ZenorixPalette.sphereElectricBlue),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Soundscape: ${item.soundscape}', style: const TextStyle(color: ZenorixPalette.textDim, fontSize: 12)),
            trailing: Text('${item.durationMinutes} min',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: ZenorixPalette.sphereElectricBlue,
                )),
          ),
        );
      },
    );
  }
}
