import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {

   final String headline;

  const NewsItem({ required this.headline});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(headline),
        onTap: () {
          // Handle onTap event (navigate to article details, for example)
        },
      ),
    );
  }
}