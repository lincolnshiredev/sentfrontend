import 'package:stockandsentiment/news_model.dart';
import 'package:flutter/material.dart';
import 'package:stockandsentiment/http_service.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  final Articles articles;
  final Datum prices;

  PostDetail({@required this.post, this.articles, this.prices});
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.name + " News"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Card(
                child: Container(
                    width: 400, child: Center(child: Text("Chart to go here"))),
              ),
            ),
              Expanded(
              flex: 2,
              child: Card(
                
                child: Container(
                    width: 400, child: Center(child: Text("Stock Details to go here (using the stock api list that has been called)."))),
              ),
            ),
        /*     Expanded(
              flex: 2,
              child: FutureBuilder(
                future: httpService.loadPrices(post.symbol),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Datum>> snapshot) {
                  if (snapshot.hasData) {
                    List<Datum> prices = snapshot.data;
                    return ListView(
                      children: prices
                          .map(
                            (Datum prices) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                child: Container(
                                  height: 150.0,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        prices.historical.close.toString(),
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ), */
            Expanded(
              flex: 5,
              child: FutureBuilder(
                future: httpService.loadStock(post.symbol),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Articles>> snapshot) {
                  if (snapshot.hasData) {
                    List<Articles> articles = snapshot.data;
                    return ListView(
                      children: articles
                          .map(
                            (Articles articles) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                child: Container(
                                  height: 150.0,
                                  child: Center(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(articles.urlToImage),
                                      ),
                                      title: Text(
                                        articles.title,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
