import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/zenorix_palette.dart';
import 'viewmodels/focus_sphere_viewmodel.dart';
import 'views/focus_sphere_view.dart';
import 'views/session_log_view.dart';
import 'views/flow_analytics_view.dart';
import 'views/soundscapes_view.dart';

class ZenorixApp extends StatelessWidget {
  const ZenorixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FocusSphereViewModel(),
      child: MaterialApp(
        title: 'Zenorix Focus Sphere',
        theme: ZenorixPalette.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const ZenorixHomeScaffold(),
      ),
    );
  }
}

class ZenorixHomeScaffold extends StatefulWidget {
  const ZenorixHomeScaffold({super.key});

  @override
  State<ZenorixHomeScaffold> createState() => _ZenorixHomeScaffoldState();
}

class _ZenorixHomeScaffoldState extends State<ZenorixHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Focus Sphere', 'Session Log', 'Flow Analytics', 'Soundscapes'];
  final _views = const [
    FocusSphereView(),
    SessionLogView(),
    FlowAnalyticsView(),
    SoundscapesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _views[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.bubble_chart_outlined), selectedIcon: Icon(Icons.bubble_chart), label: 'Sphere'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'Logs'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Analytics'),
          NavigationDestination(icon: Icon(Icons.headphones_outlined), selectedIcon: Icon(Icons.headphones), label: 'Sounds'),
        ],
      ),
    );
  }
}
