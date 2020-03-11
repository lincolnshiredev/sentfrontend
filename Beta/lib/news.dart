import 'package:stockandsentiment/http_service.dart';
import 'package:stockandsentiment/news_detail.dart';
import 'package:stockandsentiment/news_model.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  final int min = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      bottomNavigationBar: makeBottom,
      appBar: AppBar(
        title: Text(
          "Stock Prices",
          style: TextStyle(color: Colors.white),
        ),
      ),
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
                        child: Card(
                          color: Color(0xFF1B1E28),
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9),
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
                                      backgroundColor: Colors.purpleAccent,
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  SizedBox(height: 7.0),
                                  Text(
                                    "\$" + post.price.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
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
