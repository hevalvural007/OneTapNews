import 'package:dio/dio.dart' show Dio;

import '../../data/entity/article.dart';
import '../../data/entity/response.dart';

class RequestController{
  static const String apiKey = String.fromEnvironment('API_KEY');


  List<Article> parseArticles(dynamic response){
    return Response.fromJson(response).articles;
  }

  Future<List<Article>> uploadTopicArticles(String topic) async {

    final response = await Dio().get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'language': 'en',
        'category': topic,
        'pageSize': 100,
        'apiKey': apiKey,
      },
    );

    return parseArticles(response.data);
  }
  Future<List<Article>> uploadArticles(String language) async{
    final response = await Dio().get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': 'news',
        'language': language,
        'sortBy': 'publishedAt',
        'pageSize': 100,
        'apiKey': apiKey,
      },
    );
    return parseArticles(response.data);
  }
}