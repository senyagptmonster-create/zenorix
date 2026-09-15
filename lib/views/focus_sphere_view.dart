import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/focus_sphere_viewmodel.dart';
import '../ui/zenorix_palette.dart';

class FocusSphereView extends StatelessWidget {
  const FocusSphereView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FocusSphereViewModel>();
    final mins = (vm.remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (vm.remainingSeconds % 60).toString().padLeft(2, '0');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ZenorixPalette.cardBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.waves, color: ZenorixPalette.sphereElectricBlue, size: 18),
                const SizedBox(width: 8),
                Text('Soundscape: ${vm.activeSoundscape}',
                    style: const TextStyle(fontSize: 13, color: ZenorixPalette.textDim)),
              ],
            ),
          ),
          const SizedBox(height: 36),
          // Geometric focus sphere
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: 200 * vm.sphereScale,
            height: 200 * vm.sphereScale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  ZenorixPalette.sphereElectricBlue.withValues(alpha: 0.9),
                  ZenorixPalette.sphereNeonPurple.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
                stops: const [0.3, 0.7, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: ZenorixPalette.sphereElectricBlue.withValues(alpha: vm.isActive ? 0.4 : 0.1),
                  blurRadius: 30,
                  spreadRadius: 8,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$mins:$secs',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    )),
                Text(vm.isActive ? 'EXPANDING' : 'READY',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: vm.isActive ? Colors.white70 : ZenorixPalette.textDim,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => vm.resetTimer(),
                icon: const Icon(Icons.refresh),
                iconSize: 26,
              ),
              const SizedBox(width: 24),
              FilledButton.icon(
                onPressed: () => vm.toggleTimer(),
                icon: Icon(vm.isActive ? Icons.pause : Icons.play_arrow),
                label: Text(vm.isActive ? 'Pause Focus' : 'Initiate Sphere'),
                style: FilledButton.styleFrom(
                  backgroundColor: ZenorixPalette.sphereElectricBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          // Preset duration selectors
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [15, 25, 45, 60].map((duration) {
              final isSelected = vm.sessionMinutes == duration;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text('$duration m'),
                  selected: isSelected,
                  onSelected: (_) => vm.setSessionDuration(duration),
                  selectedColor: ZenorixPalette.sphereElectricBlue,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
