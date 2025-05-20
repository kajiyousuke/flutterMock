enum FortuneCategory {
  general,
  love,
  money,
  work,
  health,
}

class Fortune {
  final String text;
  final String color;

  Fortune({required this.text, required this.color});
}
