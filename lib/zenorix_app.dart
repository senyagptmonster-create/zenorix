import 'dart:async';
import 'package:flutter/material.dart';
import 'theme/zenorix_theme.dart';
import 'painters/isometric_sphere_painter.dart';

class ZenorixApp extends StatelessWidget {
  const ZenorixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenorix Focus Sphere',
      debugShowCheckedModeBanner: false,
      theme: ZenorixTheme.themeData,
      home: const ZenorixFocusScreen(),
    );
  }
}

class ZenorixFocusScreen extends StatefulWidget {
  const ZenorixFocusScreen({super.key});

  @override
  State<ZenorixFocusScreen> createState() => _ZenorixFocusScreenState();
}

class _ZenorixFocusScreenState extends State<ZenorixFocusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  Timer? _sessionTimer;

  int _sessionMinutes = 25;
  int _secondsRemaining = 25 * 60;
  bool _isRunning = false;

  final List<Map<String, String>> _sessionLogs = [
    {'title': 'Deep Architecture Review', 'duration': '45m', 'time': '10:30 AM'},
    {'title': 'Code Refactoring Sprint', 'duration': '25m', 'time': '01:15 PM'},
    {'title': 'Documentation Draft', 'duration': '30m', 'time': '03:40 PM'},
  ];

  final List<String> _soundscapes = [
    'Deep Space Drone',
    'Rain on Cedar Roof',
    'Binaural Alpha Waves',
    'Nocturnal Forest Crickets',
    'Quiet Library Whisper',
  ];
  String _selectedSoundscape = 'Deep Space Drone';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    _sessionTimer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _sessionTimer?.cancel();
        _isRunning = false;
      } else {
        _isRunning = true;
        _sessionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (_secondsRemaining > 0) {
            setState(() => _secondsRemaining--);
          } else {
            t.cancel();
            setState(() {
              _isRunning = false;
              _secondsRemaining = _sessionMinutes * 60;
            });
          }
        });
      }
    });
  }

  void _resetTimer() {
    _sessionTimer?.cancel();
    setState(() {
      _isRunning = false;
      _secondsRemaining = _sessionMinutes * 60;
    });
  }

  void _setDuration(int mins) {
    _sessionTimer?.cancel();
    setState(() {
      _sessionMinutes = mins;
      _secondsRemaining = mins * 60;
      _isRunning = false;
    });
  }

  String _formatTime(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final totalSecs = _sessionMinutes * 60;
    final progress = (totalSecs - _secondsRemaining) / totalSecs;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ZENORIX FOCUS SPHERE',
          style: TextStyle(
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: ZenorixTheme.ink,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: ZenorixTheme.accentLight),
            onPressed: _showSessionLogsSheet,
          ),
          IconButton(
            icon: const Icon(Icons.graphic_eq_rounded, color: ZenorixTheme.accentLight),
            onPressed: _showSoundscapeSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Ambient sound badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: ZenorixTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ZenorixTheme.edge),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.waves, size: 16, color: ZenorixTheme.accentLight),
                    const SizedBox(width: 8),
                    Text(
                      _selectedSoundscape,
                      style: const TextStyle(fontSize: 12, color: ZenorixTheme.muted, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Isometric Sphere Custom Painter
              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return SizedBox(
                    width: 260,
                    height: 260,
                    child: CustomPaint(
                      painter: IsometricSpherePainter(
                        animationValue: _animController.value,
                        focusProgress: progress,
                        isActive: _isRunning,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatTime(_secondsRemaining),
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: ZenorixTheme.ink,
                              ),
                            ),
                            Text(
                              _isRunning ? 'DEEP WORK' : 'SPHERE READY',
                              style: TextStyle(
                                fontSize: 11,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: _isRunning ? ZenorixTheme.accentLight : ZenorixTheme.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              // Control action button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _toggleTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZenorixTheme.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      _isRunning ? 'PAUSE SPHERE' : 'EXPAND SPHERE',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: _resetTimer,
                    style: IconButton.styleFrom(
                      backgroundColor: ZenorixTheme.surface,
                      foregroundColor: ZenorixTheme.ink,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Duration selector pills
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [15, 25, 45, 60].map((mins) {
                  final isSel = _sessionMinutes == mins;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text('${mins}m'),
                      selected: isSel,
                      selectedColor: ZenorixTheme.accent,
                      labelStyle: TextStyle(
                        color: isSel ? Colors.white : ZenorixTheme.muted,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: ZenorixTheme.surface,
                      onSelected: (_) => _setDuration(mins),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSessionLogsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ZenorixTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Completed Focus Sessions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ZenorixTheme.ink)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const Divider(color: ZenorixTheme.edge),
                ..._sessionLogs.map((log) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: ZenorixTheme.edge,
                        child: Icon(Icons.check, color: ZenorixTheme.accentLight, size: 18),
                      ),
                      title: Text(log['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(log['time']!, style: const TextStyle(fontSize: 12, color: ZenorixTheme.muted)),
                      trailing: Text(log['duration']!, style: const TextStyle(fontWeight: FontWeight.bold, color: ZenorixTheme.accentLight)),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSoundscapeSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ZenorixTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ambient Soundscapes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ZenorixTheme.ink)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const Divider(color: ZenorixTheme.edge),
                ..._soundscapes.map((s) {
                  final isSel = _selectedSoundscape == s;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(s, style: TextStyle(fontWeight: isSel ? FontWeight.bold : FontWeight.normal, color: isSel ? ZenorixTheme.accentLight : ZenorixTheme.ink)),
                    trailing: isSel ? const Icon(Icons.check_circle, color: ZenorixTheme.accentLight) : null,
                    onTap: () {
                      setState(() => _selectedSoundscape = s);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
