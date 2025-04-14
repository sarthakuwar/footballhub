// lib/models/news.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String? content;
  final String? imageUrl;
  final DateTime publishDate;

  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    this.content,
    this.imageUrl,
    required this.publishDate,
  });

  factory NewsArticle.fromFirestore(Map<String, dynamic> data, String id) {
    return NewsArticle(
      id: id,
      title: data['title'] ?? '',
      summary: data['summary'] ?? '',
      content: data['content'],
      imageUrl: data['imageUrl'],
      publishDate: (data['publishDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}