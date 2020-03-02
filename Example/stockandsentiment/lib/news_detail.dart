import 'package:stockandsentiment/news_model.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News Fields"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Title"),
                        subtitle: Text(post.title),
                      ),
                      ListTile(
                        title: Text("Date"),
                        subtitle: Text(post.publishedAt),
                      ),
                      ListTile(
                        title: Text("Ticker"),
                        subtitle: Text(post.ticker),
                      ),
                      ListTile(
                        title: Text("Last Price"),
                        subtitle: Text(post.lastPrice),
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}