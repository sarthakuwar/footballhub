// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/player.dart';
import '../services/firebase_service.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF388E3C), Color(0xFFE8F5E9)],
          ),
        ),
        child: StreamBuilder<List<Player>>(
          stream: _firebaseService.getTopPlayers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading data: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final players = snapshot.data ?? [];
            
            if (players.isEmpty) {
              return Center(
                child: Text(
                  'No players found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Top Players',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/stadium.jpg', // Use a local asset instead of network image
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.5),
                          colorBlendMode: BlendMode.darken,
                        ),
                        // Fallback to a gradient if no image
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Color(0xFF1B5E20),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final player = players[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFF44336),
                          child: Text(
                            '${player.rank}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          player.name,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(player.team),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      )
                          .animate()
                          .fadeIn(delay: Duration(milliseconds: index * 100))
                          .slideY(begin: 0.2, end: 0);
                    },
                    childCount: players.length,
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