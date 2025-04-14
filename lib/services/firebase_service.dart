// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart';
import '../models/match.dart';
import '../models/news.dart';
import '../models/standing.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Players
  Stream<List<Player>> getTopPlayers() {
    return _firestore
        .collection('players')
        .orderBy('rank')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Player.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Matches
  Stream<List<FootballMatch>> getUpcomingMatches() {
    return _firestore
        .collection('matches')
        .orderBy('date')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FootballMatch.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // News
  Stream<List<NewsArticle>> getLatestNews() {
    return _firestore
        .collection('news')
        .orderBy('publishDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NewsArticle.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // Standings
  Stream<List<Standing>> getLeagueStandings() {
    return _firestore
        .collection('standings')
        .orderBy('position')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Standing.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }
}