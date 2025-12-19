import 'package:ot_news/data/entity/article.dart';

class Response{
  String status;
  int totalResults;
  List<Article> articles;

  Response(this.status, this.totalResults, this.articles);

  factory Response.fromJson(Map<String,dynamic> json){
    var status = json['status'] as String;
    var totalResults = json['totalResults'] as int;
    var jsonArray = json['articles'] as List;


    var news = jsonArray.map((e) => Article.fromJson(e)).toList();
    return Response(status, totalResults, news);
  }
}