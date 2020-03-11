import 'dart:convert';

class Post {
  String symbol;
  String name;
  double price;
  double changesPercentage;
  double change;
  double dayLow;
  double dayHigh;
  double yearHigh;
  double yearLow;
  double marketCap;
  double priceAvg50;
  double priceAvg200;
  int volume;
  int avgVolume;
  String exhange;
  double open;
  double previousClose;
  double eps;
  double pe;
  String earningsAnnouncement;
  int sharesOutstanding;
  int timestamp;

  Post({
    this.symbol,
    this.name,
    this.price,
    this.changesPercentage,
    this.change,
    this.dayLow,
    this.dayHigh,
    this.yearHigh,
    this.yearLow,
    this.marketCap,
    this.priceAvg50,
    this.priceAvg200,
    this.volume,
    this.avgVolume,
    this.exhange,
    this.open,
    this.previousClose,
    this.eps,
    this.pe,
    this.earningsAnnouncement,
    this.sharesOutstanding,
    this.timestamp,
  });

  Post.fromJson(Map<String, dynamic> json) {
    symbol = json["symbol"];
    name = json["name"];
    price = json["price"].toDouble();
    changesPercentage = json["changesPercentage"].toDouble();
    change = json["change"].toDouble();
    dayLow = json["dayLow"].toDouble();
    dayHigh = json["dayHigh"].toDouble();
    yearHigh = json["yearHigh"].toDouble();
    yearLow = json["yearLow"].toDouble();
    marketCap = json["marketCap"].toDouble();
    priceAvg50 = json["priceAvg50"].toDouble();
    priceAvg200 = json["priceAvg200"].toDouble();
    volume = json["volume"];
    avgVolume = json["avgVolume"];
    exhange = json["exhange"];
    open = json["open"].toDouble();
    previousClose = json["previousClose"].toDouble();
    eps = json["eps"].toDouble();
    pe = json["pe"].toDouble();
    earningsAnnouncement = json["earningsAnnouncement"];
    sharesOutstanding = json["sharesOutstanding"];
    timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["symbol"] = this.symbol;
    data["name"] = this.name;
    data["price"] = this.price;
    data["changesPercentage"] = this.changesPercentage;
    data["change"] = this.change;
    data["dayLow"] = this.dayLow;
    data["dayHigh"] = this.dayHigh;
    data["yearHigh"] = this.yearHigh;
    data["yearLow"] = this.yearLow;
    data["marketCap"] = this.marketCap;
    data["priceAvg50"] = this.priceAvg50;
    data["priceAvg200"] = this.priceAvg50;
    data["volume"] = this.volume;
    data["avgVolume"] = this.avgVolume;
    data["exhange"] = this.exhange;
    data["open"] = this.open;
    data["previousClose"] = this.previousClose;
    data["eps"] = this.eps;
    data["pe"] = this.pe;
    data["earningsAnnouncement"] = this.earningsAnnouncement;
    data["sharesOutstanding"] = this.sharesOutstanding;
    data["timestamp"] = this.timestamp;
    return data;
  }
}

Stock stockFromJson(String str) => Stock.fromJson(json.decode(str));

String stockToJson(Stock data) => json.encode(data.toJson());

class Stock {
  List<Articles> articles;
  AdditionalData additionalData;

  Stock({
    this.articles,
    this.additionalData,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        articles: List<Articles>.from(
            json["articles "].map((x) => Articles.fromJson(x))),
        additionalData: AdditionalData.fromJson(json["additionalData"]),
      );

  Map<String, dynamic> toJson() => {
        "articles ": List<dynamic>.from(articles.map((x) => x.toJson())),
        "additionalData": additionalData.toJson(),
      };
}

class AdditionalData {
  int numberOfArticles;
  double overallSentiment;
  String avgSentiment;

  AdditionalData({
    this.numberOfArticles,
    this.overallSentiment,
    this.avgSentiment,
  });

  factory AdditionalData.fromJson(Map<String, dynamic> json) => AdditionalData(
        numberOfArticles: json["numberOfArticles"],
        overallSentiment: json["overallSentiment"].toDouble(),
        avgSentiment: json["avgSentiment"],
      );

  Map<String, dynamic> toJson() => {
        "numberOfArticles": numberOfArticles,
        "overallSentiment": overallSentiment,
        "avgSentiment": avgSentiment,
      };
}

class Articles {
  dynamic publishedAt;
  double sentiment;
  String sourceName;
  String title;
  String url;
  String urlToImage;

  Articles({
    this.publishedAt,
    this.sentiment,
    this.sourceName,
    this.title,
    this.url,
    this.urlToImage,
  });

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        publishedAt: json["publishedAt"],
        sentiment: json["sentiment"].toDouble(),
        sourceName: json["sourceName"],
        title: json["title"],
        url: json["url"],
        urlToImage: json["urlToImage"],
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt,
        "sentiment": sentiment,
        "sourceName": sourceName,
        "title": title,
        "url": url,
        "urlToImage": urlToImage,
      };
}

Prices pricesFromJson(String str) => Prices.fromJson(json.decode(str));

String pricesToJson(Prices data) => json.encode(data.toJson());

class Prices {
  CompanyData companyData;
  List<Datum> data;

  Prices({
    this.companyData,
    this.data,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        companyData: CompanyData.fromJson(json["companyData"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companyData": companyData.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CompanyData {
  Profile profile;

  CompanyData({
    this.profile,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
      };
}

class Profile {
  String ceo;
  String companyName;
  String exchange;
  String image;
  double price;
  String sector;
  String website;

  Profile({
    this.ceo,
    this.companyName,
    this.exchange,
    this.image,
    this.price,
    this.sector,
    this.website,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        ceo: json["ceo"],
        companyName: json["companyName"],
        exchange: json["exchange"],
        image: json["image"],
        price: json["price"].toDouble(),
        sector: json["sector"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "ceo": ceo,
        "companyName": companyName,
        "exchange": exchange,
        "image": image,
        "price": price,
        "sector": sector,
        "website": website,
      };
}

class Datum {
  Historical historical;

  Datum({
    this.historical,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        historical: Historical.fromJson(json["historical"]),
      );

  Map<String, dynamic> toJson() => {
        "historical": historical.toJson(),
      };
}

class Historical {
  DateTime date;
  double open;
  double high;
  double low;
  String close;
  double adjClose;
  double volume;
  double unadjustedVolume;
  double change;
  double changePercent;
  double vwap;
  String label;
  double changeOverTime;

  Historical({
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.adjClose,
    this.volume,
    this.unadjustedVolume,
    this.change,
    this.changePercent,
    this.vwap,
    this.label,
    this.changeOverTime,
  });

  factory Historical.fromJson(Map<String, dynamic> json) => Historical(
        date: DateTime.parse(json["date"]),
        open: json["open"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        close: json["close"].toString(),
        adjClose: json["adjClose"].toDouble(),
        volume: json["volume"].toDouble(),
        unadjustedVolume: json["unadjustedVolume"].toDouble(),
        change: json["change"].toDouble(),
        changePercent: json["changePercent"].toDouble(),
        vwap: json["vwap"].toDouble(),
        label: json["label"],
        changeOverTime: json["changeOverTime"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "adjClose": adjClose,
        "volume": volume,
        "unadjustedVolume": unadjustedVolume,
        "change": change,
        "changePercent": changePercent,
        "vwap": vwap,
        "label": label,
        "changeOverTime": changeOverTime,
      };
}
