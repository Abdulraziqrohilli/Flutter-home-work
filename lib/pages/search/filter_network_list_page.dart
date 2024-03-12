import 'dart:async';

import 'package:hurriyat/services/search/search_api.dart';
import 'package:hurriyat/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:hurriyat/models/article_model.dart';

class FilterNetworkListPage extends StatefulWidget {
  int languageid;
  FilterNetworkListPage(this.languageid);
  @override
  FilterNetworkListPageState createState() => FilterNetworkListPageState();
}

class FilterNetworkListPageState extends State<FilterNetworkListPage> {
  List<ArticleModel> news = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final newss = await SearchApi.getNews(query,widget.languageid);

    setState(() => this.news = newss);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final newsss = news[index];

                  return buildBook(newsss);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Description',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final news = await SearchApi.getNews(query,widget.languageid);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.news = news;
        });
      });

  Widget buildBook(ArticleModel news) => ListTile(
        leading: Image.network(
          news.urlToImage.toString(),
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(news.title.toString()),
        subtitle: Text(news.description.toString()),
      );
}
