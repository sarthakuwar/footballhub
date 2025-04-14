class Standing {
  final String id;
  final String team;
  final int points;
  final int position;
  final int? played;
  final int? won;
  final int? drawn;
  final int? lost;

  Standing({
    required this.id,
    required this.team,
    required this.points,
    required this.position,
    this.played,
    this.won,
    this.drawn,
    this.lost,
  });

  factory Standing.fromFirestore(Map<String, dynamic> data, String id) {
    return Standing(
      id: id,
      team: data['team'] ?? '',
      points: data['points'] ?? 0,
      position: data['position'] ?? 0,
      played: data['played'],
      won: data['won'],
      drawn: data['drawn'],
      lost: data['lost'],
    );
  }
}