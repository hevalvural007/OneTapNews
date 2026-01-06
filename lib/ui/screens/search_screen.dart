import 'dart:async';
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ot_news/ui/widgets/tab_screen.dart';
import '../../data/entity/response.dart';
import '../../data/entity/article.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String apiKey = String.fromEnvironment('API_KEY');
  bool isSearching = false;
  bool isLoading = false;
  var tfSearchWord = TextEditingController();

  List<Article> articles = [];
  Timer? _debounce;

  List<Article> parseArticles(dynamic response){
    return Response.fromJson(response).articles;
  }

  Future<void> searchArticles(String query) async {
    if (query.isEmpty) {
      setState(() {
        articles = [];
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await Dio().get(
          'https://newsapi.org/v2/everything',
          queryParameters: {
            'language' :'en',
            'q': query,
            'sortBy': 'publishedAt',
            'pageSize': 100,
            'apiKey': apiKey,
          }
      );

      var newArticles = parseArticles(response.data);

      setState(() {
        articles = newArticles;
        isLoading = false; //
      });

    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchArticles(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    tfSearchWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              title: isSearching
                  ? TextField(
                controller: tfSearchWord,
                autofocus: true,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                    hintText: 'Search by keyword...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none
                ),
                style: TextStyle(color: Colors.white),
              )
                  : Text(""),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching;
                        if (!isSearching) {
                          tfSearchWord.clear();
                          articles = [];
                        }
                      });
                    },
                    icon: Icon(
                      isSearching ? FontAwesomeIcons.xmark : FontAwesomeIcons.magnifyingGlass,
                      color: Colors.white,
                    ))
              ],
            )
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFF5A2E98)))
            : articles.isNotEmpty
            ? ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            var article = articles[index];
            return TabScreen(article);
          },
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tfSearchWord.text.isEmpty
                    ? FontAwesomeIcons.magnifyingGlass
                    : FontAwesomeIcons.faceFrown,
                size: 50,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                tfSearchWord.text.isEmpty
                    ? "Click on the Search Icon."
                    : "No result for '${tfSearchWord.text}'.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}