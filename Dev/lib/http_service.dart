import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockandsentiment/news_model.dart';

class HttpService {
  // final String postsURL =
  //     "https://financialmodelingprep.com/api/v3/quote/,MSFT,AAPL,GOOGL,AMZN,PYPL,IBM,EA,ADBE";

  Future<List<Post>> getPosts() async {
    String postsURL = await getUrlLocally();
    Response res = await get(postsURL);

    //print(res.body);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      //loadPrices("msft") ;

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

  static Future<bool> isNewRun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _bool = sharedPreferences.getString('isFirstRun');

    print(_bool);

    if (_bool == null) {
      sharedPreferences.setString('isFirstRun', "false");
      return true;
    } else {
      return false;
    }
  }

  static removeTickerFromLocal(String ticker) async {
    String api = await getUrlLocally();
    final updatedApi = api.replaceFirst(",$ticker", "");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('api', updatedApi);
    return;
  }

  static getUrlLocally() async {
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

  static writeUrlLocalally(String tick) async {
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

  Future<List<Articles>> loadStock(ticker) async {
    final String stockURL =
        "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/newsOutput.json";
    // "https://us-central1-enhanced-bebop-268815.cloudfunctions.net/getArticles?ticker=" + ticker;
    Response res = await get(stockURL);
    if (res.statusCode == 200) {
      // loadPrices(ticker);
      final stocks = stockFromJson(res.body);

      return stocks.articles;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  static Future<Prices> loadPrices(ticker) async {
    final String pricesURL =
        "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/stockOutput.json";
    //"https://us-central1-enhanced-bebop-268815.cloudfunctions.net/stockData?ticker=" +
    // ticker +
    // "&days=27";
    print(pricesURL);
    Response res = await get(pricesURL);
    if (res.statusCode == 200) {
      // print("got data");
      final prices = pricesFromJson(res.body);

      return prices;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  //Stock data
  Future<Map<String, dynamic>> loadStockInfo(String ticker) async {
    //Urls
    String urlAdditionalData =
        "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/newsOutput.json";

    String urlPriceAndLogo =
        "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/stockOutput.json";

    //Responses of Urls in String Form
    Response additionalData = await get(urlAdditionalData);
    Response priceAndLogo = await get(urlPriceAndLogo);

    //Responses In Json Form
    Map<String, dynamic> additionalDataJson = json.decode(additionalData.body);
    Map<String, dynamic> priceAndLogoJson = json.decode(priceAndLogo.body);

    //Collecting data from both urls
    Map<String, dynamic> collectedData = {
      "articlesAmount": additionalDataJson['additionalData']
          ['numberOfArticles'],
      "numberOfArticles": additionalDataJson['additionalData']
          ['numberOfArticles'],
      "sentiment": additionalDataJson['additionalData']['avgSentiment'],
      "price": priceAndLogoJson['companyData']['profile']['price'],
      "image": priceAndLogoJson['companyData']['profile']['image'],
    };
    return collectedData;
  }
}
