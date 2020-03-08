import 'package:stockandsentiment/news_model.dart';
import 'package:flutter/material.dart';
import 'package:stockandsentiment/http_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetail extends StatefulWidget {
  final Post post;
  final Articles articles;
  final Datum prices;

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
                    new EdgeInsets.symmetric(horizontal: 50.0, vertical: 2.0),
                child: Container(
                  //height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: Duration(milliseconds: 250),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              flex: 2,
              child: Card(
                color: Color(0xFF1B1E28),
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  width: 400,
                  child: Center(
                    child: Text(
                      "Sentiment and Stock Details Here",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /*   Expanded(
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
            ),  */
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
                                            await launch(url,forceWebView: true);
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

LineChartData sampleData1() {
  return LineChartData(
    gridData: const FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'jan';
            case 7:
              return 'feb';
            case 12:
              return 'mar';
            case 17:
              return 'apr';
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: TextStyle(
          color: const Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1m';
            case 2:
              return '2m';
            case 3:
              return '3m';
            case 4:
              return '5m';
          }
          return '';
        },
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    lineBarsData: linesBarData1(),
  );
}

List<LineChartBarData> linesBarData1() {
  LineChartBarData lineChartBarData1 = const LineChartBarData(
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(14, 1.8),
      FlSpot(16, 1.8),
    ],
    isCurved: false,
    colors: [
      Color(0xff4af699),
    ],
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  return [
    lineChartBarData1,
  ];
}
