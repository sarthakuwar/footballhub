// lib/screens/news_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/news.dart';
import '../services/firebase_service.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD81B60), Color(0xFFFFEBEE)],
          ),
        ),
        child: StreamBuilder<List<NewsArticle>>(
          stream: _firebaseService.getLatestNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading news: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final articles = snapshot.data ?? [];
            
            if (articles.isEmpty) {
              return Center(
                child: Text(
                  'No news articles found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'Football News',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Color(0xFFD81B60),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final article = articles[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article.imageUrl != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.network(
                                    article.imageUrl!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 150,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                              ListTile(
                                contentPadding: EdgeInsets.all(16),
                                title: Text(
                                  article.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    Text(article.summary),
                                    SizedBox(height: 8),
                                    Text(
                                      DateFormat('MMM d, yyyy').format(article.publishDate),
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFFF44336),
                                ),
                                onTap: () {
                                  // Navigate to article details (future enhancement)
                                },
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: index * 100))
                            .slideX(begin: 0.2, end: 0);
                      },
                      childCount: articles.length,
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