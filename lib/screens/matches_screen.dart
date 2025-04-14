// lib/screens/matches_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/match.dart';
import '../services/firebase_service.dart';

class MatchesScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1976D2), Color(0xFFE3F2FD)],
          ),
        ),
        child: StreamBuilder<List<FootballMatch>>(
          stream: _firebaseService.getUpcomingMatches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading matches: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final matches = snapshot.data ?? [];
            
            if (matches.isEmpty) {
              return Center(
                child: Text(
                  'No upcoming matches found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'Upcoming Matches',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Color(0xFF1976D2),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final match = matches[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.sports_soccer,
                              color: Color(0xFFF44336),
                              size: 40,
                            ),
                            title: Text(
                              match.match,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(match.date),
                                if (match.time != null) 
                                  Text('Time: ${match.time}'),
                                if (match.venue != null) 
                                  Text('Venue: ${match.venue}'),
                              ],
                            ),
                            isThreeLine: match.time != null || match.venue != null,
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: index * 100))
                            .scale();
                      },
                      childCount: matches.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}