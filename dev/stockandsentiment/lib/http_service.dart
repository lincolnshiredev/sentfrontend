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
       // "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/dev/newsOutput.json";
     "https://us-central1-enhanced-bebop-268815.cloudfunctions.net/getArticles?ticker=" + ticker;
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
        "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/newsOutput.json" 
            ;

    String urlPriceAndLogo =
        "https://raw.githubusercontent.com/lincolnshiredev/sentbackend/master/release/Outputs/stockOutput.json" 
            ;

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
