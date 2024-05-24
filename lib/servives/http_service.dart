import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '5afcf8264abf4d82aea6c75c4ceb1090';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}

class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
    );
  }
}

