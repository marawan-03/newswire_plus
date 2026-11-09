import 'package:news_app/models/news_model.dart';

class ArticleDetails extends News {
  String thumbnail;
  String incipit;
  String body;
  String original_url;
  List<String> authors;
  List<String> topics;

  ArticleDetails({
    required this.thumbnail,
    required this.incipit,
    required this.body,
    required this.original_url,
    required this.authors,
    required this.topics,
    required super.title,
    required super.publisher,
    required super.published_at,
    required super.uuid,

  });
  factory ArticleDetails.fromJson(Map<String, dynamic> json) {
    return ArticleDetails(
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      body: json['body'] ?? '',
      incipit: json['incipit'] ?? '',
      original_url: json['original_url'] ?? '',
      publisher: json['publisher'] ?? '',
      published_at: json['published_at'] ?? '',
      uuid: json['uuid'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
      topics: List<String>.from(json['topics'] ?? []),
    );
  }
}
