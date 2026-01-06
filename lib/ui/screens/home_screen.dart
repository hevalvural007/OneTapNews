import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ot_news/data/entity/article.dart';
import 'package:ot_news/logic/controllers/request_controller.dart';
import 'package:ot_news/ui/widgets/custom_future_builder.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RequestController _requestController = RequestController();
  late Future<List<Article>> _techFuture;
  late Future<List<Article>> _sportsFuture;
  late Future<List<Article>> _financeFuture;
  late Future<List<Article>> _politicFuture;
  late Future<List<Article>> _musicFuture;
  late Future<List<Article>> _generalFuture;
  late Future<List<Article>> _turkishFuture;

  @override
  void initState() {
    super.initState();
    _techFuture = _requestController.uploadTopicArticles('technology');
    _sportsFuture = _requestController.uploadTopicArticles('sports');
    _financeFuture = _requestController.uploadTopicArticles('business');
    _politicFuture = _requestController.uploadTopicArticles('politics');
    _musicFuture = _requestController.uploadTopicArticles('music');
    _generalFuture = _requestController.uploadArticles('en');
    _turkishFuture = _requestController.uploadArticles('tr');
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
            CustomFutureBuilder(articleFuture: _generalFuture),
            CustomFutureBuilder(articleFuture: _sportsFuture),
            CustomFutureBuilder(articleFuture: _financeFuture),
            CustomFutureBuilder(articleFuture: _techFuture),
            CustomFutureBuilder(articleFuture: _politicFuture),
            CustomFutureBuilder(articleFuture: _turkishFuture),
            CustomFutureBuilder(articleFuture: _musicFuture),
          ]
      ),
    ));
  }
}
