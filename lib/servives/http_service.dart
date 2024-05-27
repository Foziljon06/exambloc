import 'dart:convert';
import 'package:http/http.dart';
import '../models/model.dart';

class Network {
  static String BASE = "newsapi.org"; // domain, server

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Apis */
  static String API_GET_INFOS = "/v2/everything";

  /* Http Params */
  static Map<String, String> paramsArticle() {
    Map<String, String> params = {
      'q': "tesla",
      'sortBy': 'publishedAt',
      'apiKey': '5afcf8264abf4d82aea6c75c4ceb1090'
    };
    return params;
  }

  /* Http Parsing */
  static List<Article> parseArticles(String response) {
    dynamic json = jsonDecode(response);
    return ArticleList.fromJson(json).articles;
  }
}
