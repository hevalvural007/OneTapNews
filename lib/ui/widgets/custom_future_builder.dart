import 'package:flutter/material.dart';
import 'package:ot_news/ui/widgets/tab_screen.dart';

import '../../data/entity/article.dart';

class CustomFutureBuilder extends StatelessWidget {
  Future<List<Article>> articleFuture;
   CustomFutureBuilder({
    super.key,
    required this.articleFuture
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: articleFuture, builder: (context,snapshot){
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
    });
  }
}
