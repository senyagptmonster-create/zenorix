import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'zenorix_store.dart';

class FocusSphereScreen extends StatelessWidget {
  const FocusSphereScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150, height: 150,
        decoration: BoxDecoration(shape: BoxShape.circle, color: cAccent.withValues(alpha: 0.5)),
        child: Center(child: Text('25:00', style: AppTheme.display(cSurface))),
      ),
    );
  }
}

class SessionLogScreen extends StatelessWidget {
  const SessionLogScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<ZenorixStore>();
    return ListView.builder(
      itemCount: store.sessions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Session ${store.sessions[index]["id"]}', style: AppTheme.text(cInk)),
          trailing: Text('${store.sessions[index]["duration"]} min', style: AppTheme.text(cAccent)),
        );
      },
    );
  }
}

class FlowAnalyticsScreen extends StatelessWidget {
  const FlowAnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Weekly Flow: 14 hrs', style: AppTheme.display(cAccent2)),
    );
  }
}

class SoundscapesScreen extends StatelessWidget {
  const SoundscapesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ambient Rain / Brown Noise', style: AppTheme.text(cInk)),
    );
  }
}
