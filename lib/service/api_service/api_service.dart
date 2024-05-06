import 'dart:convert';
import 'package:assignment_kalpas/model/News_data/news_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<News>> getNewsDataFromApi(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    final articles = data['articles'] as List<dynamic>;
    final news = articles.map((articles) {
      return News(
        title: articles['title'],
        description: articles['description'],
        urlToImage: articles['urlToImage'],
        publishedAt: articles['publishedAt'],
        content: articles['content'],
        responseStatus: response.statusCode,
      );
    }).toList();
    return news;
  } //fetching and mapping each object into News Model.
}
