import 'dart:convert';
import 'package:http/http.dart';
import 'package:stockandsentiment/news_model.dart';

class HttpService {
  final String postsURL = "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/dev/output.json";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}