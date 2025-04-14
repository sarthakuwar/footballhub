class Player {
  final String id;
  final String name;
  final int rank;
  final String team;
  final String? imageUrl;

  Player({
    required this.id,
    required this.name,
    required this.rank,
    required this.team,
    this.imageUrl,
  });

  factory Player.fromFirestore(Map<String, dynamic> data, String id) {
    return Player(
      id: id,
      name: data['name'] ?? '',
      rank: data['rank'] ?? 0,
      team: data['team'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }
}