// lib/models/match.dart
class FootballMatch {
  final String id;
  final String match;
  final String date;
  final String? time;
  final String? venue;

  FootballMatch({
    required this.id,
    required this.match,
    required this.date,
    this.time,
    this.venue,
  });

  factory FootballMatch.fromFirestore(Map<String, dynamic> data, String id) {
    return FootballMatch(
      id: id,
      match: data['match'] ?? '',
      date: data['date'] ?? '',
      time: data['time'],
      venue: data['venue'],
    );
  }
}