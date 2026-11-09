import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_details_model.dart';

class NewsService {
  static const String _apiKey =
      '2299ba669f9719e6b0a9a19cd815354a5c88a32f23884fd2c5f3342f4a04b56e';

  Future<ArticleDetails> fetchDetails(String uuid) async {
    final url = Uri.https('api.freenewsapi.io', '/v1/details', {
      'uuid': uuid,
    });
    final response = await http.get(url, headers: {'x-api-key': _apiKey});

    if (response.statusCode != 200) {
      throw Exception('error ${response.statusCode}: ${response.body}');
    }

    final body = jsonDecode(utf8.decode(response.bodyBytes));

    return ArticleDetails.fromJson(body['data']);
  }
}
