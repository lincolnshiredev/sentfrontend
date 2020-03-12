import 'package:stockandsentiment/http_service.dart';
import 'package:stockandsentiment/news.dart';
import 'package:flutter/material.dart';
import 'package:stockandsentiment/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock & Sentiment',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      // home: PostsPage(),
      home: FutureBuilder(
        future: HttpService.isNewRun(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data) {
              return SplashScreen();
            } else {
              return PostsPage();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
