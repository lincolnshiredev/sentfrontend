import 'dart:convert';
import 'package:http/http.dart';
import 'package:stockandsentiment/news_model.dart';

class HttpService {
  final String postsURL =
      "https://financialmodelingprep.com/api/v3/quote/,MSFT,AAPL,GOOGL,AMZN,PYPL,IBM,EA,ADBE";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
     //loadPrices("msft") ;

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
Future<List<Articles>> loadStock(ticker) async {
  final String stockURL =
     //"https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/dev/newsOutput.json";
      "https://us-central1-enhanced-bebop-268815.cloudfunctions.net/getArticles?ticker=" + ticker;
Response res = await get(stockURL);
 if (res.statusCode == 200){
  
  final stocks = stockFromJson(res.body);
  
 
  return stocks.articles;
 }else{
  throw Exception ('Failed to load Data');
 }
}

Future<List<Datum>> loadPrices(ticker) async {
  final String pricesURL = 
  //"https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/stockOutput.json";
     "https://us-central1-enhanced-bebop-268815.cloudfunctions.net/stockData?ticker=" + ticker;
 
Response res = await get(pricesURL);
 if (res.statusCode == 200){
  // print("got data");
  final prices = pricesFromJson(res.body);
 // print(prices.data[0].historical.high);
  //print(stocks.articles[1].title);
  return prices.data;
 }else{
  throw Exception ('Failed to load Data');
 }
}

}
