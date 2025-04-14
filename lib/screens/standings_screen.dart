// lib/screens/standings_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/standing.dart';
import '../services/firebase_service.dart';

class StandingsScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  StandingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0288D1), Color(0xFFE1F5FE)],
          ),
        ),
        child: StreamBuilder<List<Standing>>(
          stream: _firebaseService.getLeagueStandings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading standings: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final standings = snapshot.data ?? [];
            
            if (standings.isEmpty) {
              return Center(
                child: Text(
                  'No standings data found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'League Standings',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Color(0xFF0288D1),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final standing = standings[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 30,
                              alignment: Alignment.center,
                              child: Text(
                                '#${standing.position}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF44336),
                                ),
                              ),
                            ),
                            title: Text(
                              standing.team,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: standing.played != null ? 
                              Text('P: ${standing.played} | W: ${standing.won} | D: ${standing.drawn} | L: ${standing.lost}') : 
                              null,
                            trailing: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color(0xFF1B5E20),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${standing.points} pts',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: index * 100))
                            .scale();
                      },
                      childCount: standings.length,
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