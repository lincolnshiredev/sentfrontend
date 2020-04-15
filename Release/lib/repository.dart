import 'dart:convert';
import 'package:http/http.dart';
import './models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/price_model.dart';
import 'models/stock_model.dart';

class Repository {
  //Objects and variables
  final stockApi =
      "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/newsOutput.json";
      //

  final priceApi =
      "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/stockOutput.json";
      //


  ///*****..Functions..*****///

  //This function will return true if the app is opened for very first time after install
  Future<bool> isNewRun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _bool = sharedPreferences.getString('isFirstRun');

    if (_bool == null) {
      sharedPreferences.setString('isFirstRun', "false");
      return true;
    } else {
      return false;
    }
  }

  //This function adds a ticker to device storage
  writeUrlLocalally(String tick) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      String api = await getUrlLocally();
      api = api + ',' + tick;
      await sharedPreferences.setString('api', api);
    } catch (error) {
      print(error);
    }
    return;
  }

  //This function recovers ticker from storage.
  getUrlLocally() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final api = sharedPreferences.getString('api');
      if (api == null) {
        final initialApi =
            "https://financialmodelingprep.com/api/v3/quote/,MSFT,AAPL";
        await sharedPreferences.setString("api", initialApi);
        return initialApi;
      } else {
        return api;
      }
    } catch (error) {
      print(error);
    }
  }

  //This function removes the ticker from the api
  removeTickerFromLocal(String ticker) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String api = await getUrlLocally();
      final updatedApi = api.replaceFirst(",$ticker", "");
      sharedPreferences.setString('api', updatedApi);
    } catch (e) {
      print(e);
    }
    return;
  }

  //This function gets all the json from the api stored in device storage and returns objects from json
  Future<List<Post>> getPosts() async {
    String postsURL = await getUrlLocally();
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else if (res.statusCode == 404) {
      return [];
    } else {
      throw "Can't get posts.";
    }
  }

  //Function to load stocks
  Future<Stock> loadStock(ticker) async {
   final stockApi1 = "https://us-central1-enhanced-bebop-268815.cloudfunctions.net/getArticles?ticker=" + ticker;
    Response res = await get(stockApi1);

    if (res.statusCode == 200) {
      // loadPrices(ticker);
      final jsonResponse = json.decode(res.body);
      final stock = Stock.fromJson(jsonResponse);
      return stock;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  //Function to load prices
  Future<Prices> loadPrices(ticker) async {
    final priceApi1 = "https://us-central1-enhanced-bebop-268815.cloudfunctions.net/stockData?ticker=" +
     ticker +
     "&days=27";
    Response res = await get(priceApi1);
    if (res.statusCode == 200) {
      final jsonResponse = json.decode(res.body);
      final prices = Prices.fromJson(jsonResponse);
      return prices;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
