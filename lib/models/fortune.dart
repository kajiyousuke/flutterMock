// lib/models/fortune.dart

enum FortuneCategory {
  general,
  love,
  work,
  money,
  health,
}

class Fortune {
  final String text;
  final String color;

  Fortune({required this.text, required this.color});
}
