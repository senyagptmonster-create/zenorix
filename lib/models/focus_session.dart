class FocusSession {
  final String title;
  final int durationMinutes;
  final DateTime completedAt;
  final String soundscape;

  const FocusSession({
    required this.title,
    required this.durationMinutes,
    required this.completedAt,
    required this.soundscape,
  });
}
