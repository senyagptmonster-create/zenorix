import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/focus_session.dart';

class FocusSphereViewModel extends ChangeNotifier {
  int _sessionMinutes = 25;
  int _remainingSeconds = 25 * 60;
  bool _isActive = false;
  String _activeSoundscape = 'Deep Void';
  int _totalFocusMinutesAllTime = 145;

  final List<FocusSession> _history = [
    FocusSession(
      title: 'Deep Architecture Design',
      durationMinutes: 45,
      completedAt: DateTime.now().subtract(const Duration(hours: 4)),
      soundscape: 'Binaural Delta',
    ),
    FocusSession(
      title: 'Code Refactoring Sprint',
      durationMinutes: 25,
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      soundscape: 'Deep Void',
    ),
    FocusSession(
      title: 'Algorithmic Optimization',
      durationMinutes: 50,
      completedAt: DateTime.now().subtract(const Duration(days: 2)),
      soundscape: 'Solar Wind',
    ),
  ];

  final List<String> soundscapes = [
    'Deep Void',
    'Binaural Delta',
    'Solar Wind',
    'Cosmic Rain',
    'Isochronic Pulse',
  ];

  FocusSphereViewModel() {
    _loadPrefs();
  }

  int get sessionMinutes => _sessionMinutes;
  int get remainingSeconds => _remainingSeconds;
  bool get isActive => _isActive;
  String get activeSoundscape => _activeSoundscape;
  int get totalFocusMinutesAllTime => _totalFocusMinutesAllTime;
  List<FocusSession> get history => _history;

  double get sphereScale {
    final totalSecs = _sessionMinutes * 60;
    final elapsedSecs = totalSecs - _remainingSeconds;
    // Expands smoothly from 0.7 to 1.3 as session proceeds
    return 0.7 + (0.6 * (elapsedSecs / totalSecs).clamp(0.0, 1.0));
  }

  void setSessionDuration(int minutes) {
    if (!_isActive) {
      _sessionMinutes = minutes;
      _remainingSeconds = minutes * 60;
      notifyListeners();
    }
  }

  void setSoundscape(String name) {
    _activeSoundscape = name;
    notifyListeners();
  }

  void toggleTimer() {
    _isActive = !_isActive;
    notifyListeners();
  }

  void tick() {
    if (_isActive && _remainingSeconds > 0) {
      _remainingSeconds--;
      if (_remainingSeconds == 0) {
        _isActive = false;
        _totalFocusMinutesAllTime += _sessionMinutes;
        _history.insert(
          0,
          FocusSession(
            title: 'Focus Sprint',
            durationMinutes: _sessionMinutes,
            completedAt: DateTime.now(),
            soundscape: _activeSoundscape,
          ),
        );
        _savePrefs();
      }
      notifyListeners();
    }
  }

  void resetTimer() {
    _isActive = false;
    _remainingSeconds = _sessionMinutes * 60;
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _totalFocusMinutesAllTime = prefs.getInt('zenorix_mins') ?? 145;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('zenorix_mins', _totalFocusMinutesAllTime);
  }
}
