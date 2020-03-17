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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      symbol: json["symbol"],
      name: json["name"],
      price: json["price"].toDouble(),
      changesPercentage: json["changesPercentage"].toDouble(),
      change: json["change"].toDouble(),
      dayLow: json["dayLow"].toDouble(),
      dayHigh: json["dayHigh"].toDouble(),
      yearHigh: json["yearHigh"].toDouble(),
      yearLow: json["yearLow"].toDouble(),
      marketCap: json["marketCap"].toDouble(),
      priceAvg50: json["priceAvg50"].toDouble(),
      priceAvg200: json["priceAvg200"].toDouble(),
      volume: json["volume"],
      avgVolume: json["avgVolume"],
      exhange: json["exchange"],
      open: json["open"].toDouble(),
      previousClose: json["previousClose"].toDouble(),
      eps: json["eps"].toDouble(),
      pe: json["pe"].toDouble(),
      earningsAnnouncement: json["earningsAnnouncement"],
      sharesOutstanding: json["sharesOutstanding"],
      timestamp: json["timestamp"],
    );
  }
}
