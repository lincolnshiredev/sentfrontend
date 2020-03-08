import 'package:stockandsentiment/http_service.dart';
import 'package:stockandsentiment/news_detail.dart';
import 'package:stockandsentiment/news_model.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  final _random = new Random();
  final int min = 0;

  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xFF1B1E28),
        onPressed: () {},
        child: new Icon(Icons.add),
      ),
      appBar: AppBar(
        /*   actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          )
        ], */
        title: Text("Stock Prices"),
      ),
      bottomNavigationBar: makeBottom,
      body: Container(
        child: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data;
              return ListView(
                children: posts
                    .map(
                      (Post post) => Container(
                        //height: 100.0,
                        child: Card(
                          color: Color(0xFF1B1E28),
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9),
                                border: Border(
                                  right: BorderSide(
                                      color: (post.changesPercentage < 0)
                                          ? Colors.red
                                          : Colors.green,
                                      width: 15),
                                ),
                              ),
                              child: ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white24))),
                                      child: CircleAvatar(
                                        backgroundColor: _colors[0 +
                                            _random.nextInt(_colors.length - 0)],
                                        child: Text(
                                          post.symbol[0] + post.symbol[1],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                title: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            post.symbol,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            post.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    SizedBox(height: 7.0),
                                    Text(
                                      "Price: \$" + post.price.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      post.changesPercentage.toString() + "%",
                                      style: (post.changesPercentage < 0)
                                          ? TextStyle(color: Colors.red)
                                          : TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.keyboard_arrow_right,
                                        color: Colors.white, size: 30.0),
                                  ],
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PostDetail(
                                      post: post,
                                    ),
                                  ),
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
    );
  }

  final makeBottom = Container(
    height: 75.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
