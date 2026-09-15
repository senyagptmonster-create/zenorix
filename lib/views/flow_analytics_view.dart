import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/focus_sphere_viewmodel.dart';
import '../ui/zenorix_palette.dart';

class FlowAnalyticsView extends StatelessWidget {
  const FlowAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FocusSphereViewModel>();

    final days = [
      {'day': 'Mon', 'mins': 45},
      {'day': 'Tue', 'mins': 75},
      {'day': 'Wed', 'mins': 90},
      {'day': 'Thu', 'mins': 60},
      {'day': 'Fri', 'mins': 120},
      {'day': 'Sat', 'mins': 30},
      {'day': 'Sun', 'mins': 50},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ZenorixPalette.cardBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Focus Time Recorded',
                          style: TextStyle(color: ZenorixPalette.textDim, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text('${vm.totalFocusMinutesAllTime} Minutes',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                const Icon(Icons.insights, color: ZenorixPalette.sphereElectricBlue, size: 36),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Weekly Flow Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ZenorixPalette.cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: days.map((d) {
                final height = ((d['mins'] as int) / 120.0) * 120.0;
                return Column(
                  children: [
                    Text('${d['mins']}m', style: const TextStyle(fontSize: 10, color: ZenorixPalette.textDim)),
                    const SizedBox(height: 6),
                    Container(
                      width: 22,
                      height: height.clamp(10.0, 120.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ZenorixPalette.sphereElectricBlue, ZenorixPalette.sphereNeonPurple],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(d['day'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
