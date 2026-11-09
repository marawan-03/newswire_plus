import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class NewsService {
  static const String _apiKey =
      '2299ba669f9719e6b0a9a19cd815354a5c88a32f23884fd2c5f3342f4a04b56e';

  Future<NewsPageResult> fetchNews({String? cursor}) async {
    final url = Uri.https('api.freenewsapi.io', '/v1/news', {
      'language': 'ar',
      'country': 'eg',
      if (cursor != null) 'cursor': cursor,
    });

    final response = await http.get(url, headers: {'x-api-key': _apiKey});

    if (response.statusCode != 200) {
      throw Exception('error ${response.statusCode}: ${response.body}');
    }

    final body = jsonDecode(utf8.decode(response.bodyBytes));
    final List list = body['data'];
    final meta = body['meta'] ?? {};

    return NewsPageResult(
      articles: list.map((e) => News.fromJson(e)).toList(),
      nextCursor: meta['next_cursor'],
      hasMore: meta['has_more'] ?? false,
    );
  }
}

