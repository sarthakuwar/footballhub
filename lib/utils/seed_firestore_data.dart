// lib/utils/seed_firestore_data.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeedUtil {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> seedInitialData() async {
    await _seedPlayers();
    await _seedMatches();
    await _seedNews();
    await _seedStandings();
  }

  Future<void> _seedPlayers() async {
    final playersCollection = _firestore.collection('players');
    
    // Check if data already exists
    final snapshot = await playersCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('Players data already exists. Skipping seeding.');
      return;
    }

    // Seed players data
    final players = [
      {
        'name': 'Lionel Messi',
        'rank': 1,
        'team': 'Inter Miami',
      },
      {
        'name': 'Erling Haaland',
        'rank': 2,
        'team': 'Manchester City',
      },
      {
        'name': 'Kylian Mbappé',
        'rank': 3,
        'team': 'Real Madrid',
      },
      {
        'name': 'Kevin De Bruyne',
        'rank': 4,
        'team': 'Manchester City',
      },
      {
        'name': 'Mohamed Salah',
        'rank': 5,
        'team': 'Liverpool',
      },
    ];

    for (var player in players) {
      await playersCollection.add(player);
    }
    
    print('Players data has been seeded.');
  }

  Future<void> _seedMatches() async {
    final matchesCollection = _firestore.collection('matches');
    
    // Check if data already exists
    final snapshot = await matchesCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('Matches data already exists. Skipping seeding.');
      return;
    }

    // Seed matches data
    final matches = [
      {
        'match': 'Real Madrid vs Barcelona',
        'date': 'April 15, 2025',
        'time': '20:00',
        'venue': 'Santiago Bernabéu',
      },
      {
        'match': 'Man City vs Arsenal',
        'date': 'April 17, 2025',
        'time': '19:45',
        'venue': 'Etihad Stadium',
      },
      {
        'match': 'PSG vs Marseille',
        'date': 'April 18, 2025',
        'time': '21:00',
        'venue': 'Parc des Princes',
      },
    ];

    for (var match in matches) {
      await matchesCollection.add(match);
    }
    
    print('Matches data has been seeded.');
  }

  Future<void> _seedNews() async {
    final newsCollection = _firestore.collection('news');
    
    // Check if data already exists
    final snapshot = await newsCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('News data already exists. Skipping seeding.');
      return;
    }

    // Seed news data
    final news = [
      {
        'title': 'Premier League results: Liverpool close gap to City',
        'summary': 'Liverpool won 3-0 against Tottenham to close the gap at the top of the table.',
        'content': 'Liverpool moved to within two points of Premier League leaders Manchester City with a commanding 3-0 win over Tottenham at Anfield. Goals from Salah, Núñez, and Gakpo secured all three points for the Reds, who have now won five consecutive league matches.',
        'publishDate': Timestamp.now(),
      },
      {
        'title': 'Mbappé set to leave PSG this summer',
        'summary': 'After years of speculation, the French star is finally making his move to Madrid.',
        'content': 'Kylian Mbappé has officially announced he will leave Paris Saint-Germain at the end of the season. The 26-year-old French forward is expected to join Real Madrid on a free transfer after spending seven seasons with the Parisian club.',
        'publishDate': Timestamp.now(),
      },
      {
        'title': 'Champions League Final: Predictions & Stats',
        'summary': 'Our experts analyze the upcoming Champions League final match.',
        'content': 'With the Champions League final just around the corner, football analysts are divided on who will lift the trophy. Statistical models give a slight edge to the English side, but history suggests the Spanish giants perform exceptionally well in finals regardless of form coming into the match.',
        'publishDate': Timestamp.now(),
      },
      {
        'title': 'Messi breaks another record',
        'summary': 'The Argentine superstar continues to impress in the MLS with Inter Miami.',
        'content': 'Lionel Messi has broken yet another record, becoming the fastest player to reach 20 goal contributions in MLS history. The Argentine has been in sensational form since joining Inter Miami, transforming the club into title contenders.',
        'publishDate': Timestamp.now(),
      },
    ];

    for (var article in news) {
      await newsCollection.add(article);
    }
    
    print('News data has been seeded.');
  }

  Future<void> _seedStandings() async {
    final standingsCollection = _firestore.collection('standings');
    
    // Check if data already exists
    final snapshot = await standingsCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      print('Standings data already exists. Skipping seeding.');
      return;
    }

    // Seed standings data
    final standings = [
      {
        'team': 'Man City',
        'points': 76,
        'position': 1,
        'played': 30,
        'won': 24,
        'drawn': 4,
        'lost': 2,
      },
      {
        'team': 'Liverpool',
        'points': 74,
        'position': 2,
        'played': 30,
        'won': 23,
        'drawn': 5,
        'lost': 2,
      },
      {
        'team': 'Arsenal',
        'points': 72,
        'position': 3,
        'played': 30,
        'won': 22,
        'drawn': 6,
        'lost': 2,
      },
      {
        'team': 'Tottenham',
        'points': 68,
        'position': 4,
        'played': 30,
        'won': 21,
        'drawn': 5,
        'lost': 4,
      },
      {
        'team': 'Aston Villa',
        'points': 63,
        'position': 5,
        'played': 30,
        'won': 19,
        'drawn': 6,
        'lost': 5,
      },
      {
        'team': 'Chelsea',
        'points': 59,
        'position': 6,
        'played': 30,
        'won': 17,
        'drawn': 8,
        'lost': 5,
      },
    ];

    for (var standing in standings) {
      await standingsCollection.add(standing);
    }
    
    print('Standings data has been seeded.');
  }
}