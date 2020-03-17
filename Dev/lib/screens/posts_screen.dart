import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockandsentiment/blocs/root_bloc/root_bloc.dart';
import 'package:stockandsentiment/components/tick_alert_dialog.dart';
import 'package:stockandsentiment/models/post_model.dart';
import 'dart:math';

import '../state_managers/post_states.dart';

class PostsPage extends StatelessWidget {
  final List<Post> posts;
  PostsPage({this.posts});
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
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xFF1B1E28),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return Center(
                child: TickAlertDialog((List<Post> newPosts) {
                  BlocProvider.of<RootBloc>(context)..add(PostAdded(newPosts));
                }),
              );
            },
          );
        },
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
      body: Container(
        child: posts.length > 0
            ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => Container(
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
                                color: (posts[index].changesPercentage < 0)
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
                                  backgroundColor: _colors[
                                      0 + _random.nextInt(_colors.length - 0)],
                                  child: Text(
                                    posts[index].symbol[0] +
                                        posts[index].symbol[1],
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
                                      posts[index].symbol,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      posts[index].name,
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
                                "Price: \$" + posts[index].price.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                posts[index].changesPercentage.toString() + "%",
                                style: (posts[index].changesPercentage < 0)
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
                              InkWell(
                                onTap: () {
                                  //delete post
                                  BlocProvider.of<RootBloc>(context).add(
                                      PostDelete(index, posts[index].symbol));
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostStates(post: posts[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  "No stock \n tickers found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
      ),
    );
  }
}
