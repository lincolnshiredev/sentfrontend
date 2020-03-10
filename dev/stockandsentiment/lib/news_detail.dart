import 'package:stockandsentiment/line_graph.dart';
import 'package:stockandsentiment/news_model.dart';
import 'package:flutter/material.dart';
import 'package:stockandsentiment/http_service.dart';
import 'package:stockandsentiment/stock_info_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';

class PostDetail extends StatefulWidget {
  final Post post;
  final Articles articles;
  final List prices;

  PostDetail({@required this.post, this.articles, this.prices});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final HttpService httpService = HttpService();
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(widget.post.symbol),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 5.0),
            Center(
              child: Text(
                widget.post.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              flex: 3,
              child: Card(
                elevation: 8,
                color: Color(0xFF1B1E28),
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Container(
                  //height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                        future: HttpService.loadPrices(widget.post.symbol),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(3),
                              child: LineChart(
                                sampleData1(snapshot.data),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              flex: 2,
              child: FutureBuilder(
                      future: httpService.loadStockInfo(widget.post.symbol),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return StockInfo(data: snapshot.data);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder(
                future: httpService.loadStock(widget.post.symbol),
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
                                elevation: 8,
                                color: Color(0xFF1B1E28),
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                child: ClipPath(
                                  child: Container(
                                    //height: 100,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(64, 75, 96, .9),
                                      border: Border(
                                        right: BorderSide(
                                            color: (articles.sentiment < 0)
                                                ? Colors.red
                                                : Colors.green,
                                            width: 15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(articles.urlToImage),
                                        ),
                                        onTap: () async {
                                          final url = articles.url;

                                          if (await canLaunch(url)) {
                                            await launch(url,
                                                forceWebView: true);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        title: Column(
                                          children: <Widget>[
                                            Text(
                                              articles.title,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5.0),
                                            Text(
                                              articles.sourceName,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
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
