
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ot_news/data/entity/article.dart';
import 'package:ot_news/ui/screens/tab_screen.dart';

import '../../data/entity/response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String apiKey = String.fromEnvironment('API_KEY');
  
  
  List<Article> parseArticles(dynamic response){
      return Response.fromJson(response).articles;
  }

  Future<List<Article>> uploadSportArticles() async {

    final response = await Dio().get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'language': 'en',
        'category': 'sports',
        'pageSize': 100,
        'apiKey': apiKey,
      },
    );

    return parseArticles(response.data);
  }
  Future<List<Article>> uploadFinanceArticles() async {

    final response = await Dio().get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'language': 'en',
        'category': 'business',
        'pageSize': 100,
        'apiKey': apiKey,
      },
    );

    return parseArticles(response.data);
  }
  Future<List<Article>> uploadGeneralArticles() async {

    final response = await Dio().get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': 'news',
        'language': 'en',
        'sortBy': 'publishedAt',
        'pageSize': 100,
        'apiKey': apiKey,
      },
    );

    return parseArticles(response.data);
  }

  Future<List<Article>> uploadTechArticles() async{

    final response = await Dio().get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters:{
          'language': 'en',
          'category': 'technology',
          'pageSize': 100,
          'apiKey': apiKey,
        }
    );
    return parseArticles(response.data);
  }
Future<List<Article>> uploadPoliticArticles() async{

    final response = await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters:{
          'language': 'en',
          'category': 'politics',
          'pageSize': 100,
          'apiKey': apiKey,
        });
    return parseArticles(response.data);
}
  Future<List<Article>> uploadTurkishArticles() async{

    final response = await Dio().get('https://newsapi.org/v2/everything',
        queryParameters:{
          'q': 'news',
          'language': 'tr',
          'sortBy': 'publishedAt',
          'pageSize': 100,
          'apiKey': apiKey,
        });
    return parseArticles(response.data);
  }
  Future<List<Article>> uploadMusicArticles() async{

    final response = await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters:{
          'language': 'en',
          'category': 'music',
          'pageSize': 100,
          'apiKey': apiKey,
        });
    return parseArticles(response.data);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = screenWidth/3;

    return DefaultTabController(length: 7, child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFEB4A7B),
                Color(0xFF5A2E98)
              ])
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            indicatorColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 3,
            tabAlignment: TabAlignment.start,
            tabs: [
              SizedBox(width :tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.globe,color: Colors.white,))),
              SizedBox(width: tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.futbol,color: Colors.white,))),
              SizedBox(width: tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.coins,color: Colors.white,))),
              SizedBox(width: tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.laptop,color: Colors.white,),)),
              SizedBox(width: tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.landmark,color: Colors.white,),)),
              SizedBox(width: tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.turkishLiraSign,color: Colors.white,),)),
              SizedBox(width: tabWidth,child: Tab(icon: Icon(FontAwesomeIcons.music,color: Colors.white,),))
            ],
          ),
        ),
      ),
      body: TabBarView(
          children: [
            FutureBuilder(future: uploadGeneralArticles(), builder: (context,snapshot){
            if(snapshot.hasData){
              var articles = snapshot.data;
              return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                var article = articles[index];

                return TabScreen(article);
              },);
            }
            else{
              return Center(
                child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
              );
            }
            }),


            FutureBuilder(future: uploadSportArticles(), builder: (context,snapshot){
              if(snapshot.hasData){
                var articles = snapshot.data;
                return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                  var article = articles[index];

                  return TabScreen(article);
                },);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
                );
              }
            }),


            FutureBuilder(future: uploadFinanceArticles(), builder: (context,snapshot){
            if(snapshot.hasData){
              var articles = snapshot.data;
              return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                var article = articles[index];

                return TabScreen(article);
              },);
            }
            else{
              return Center(
                child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
              );
            }
            }),
            FutureBuilder(future: uploadTechArticles(), builder: (context,snapshot){
              if(snapshot.hasData){
                var articles = snapshot.data;
                return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                  var article = articles[index];

                  return TabScreen(article);


                },);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
                );
              }
            }),
            FutureBuilder(future: uploadPoliticArticles(), builder: (context,snapshot){
              if(snapshot.hasData){
                var articles = snapshot.data;
                return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                  var article = articles[index];

                  return TabScreen(article);

                },);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
                );
              }
            }),
            FutureBuilder(future: uploadTurkishArticles(), builder: (context,snapshot){
              if(snapshot.hasData){
                var articles = snapshot.data;
                return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                  var article = articles[index];

                  return TabScreen(article);

                },);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
                );
              }
            }),
            FutureBuilder(future: uploadMusicArticles(), builder: (context,snapshot){
              if(snapshot.hasData){
                var articles = snapshot.data;
                return ListView.builder(itemCount: articles!.length,itemBuilder: (context,index){
                  var article = articles[index];

                  return TabScreen(article);

                },);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3,),
                );
              }
            }),
          ]
      ),
    ));
  }
}
