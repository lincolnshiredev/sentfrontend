class Post {
  String publishedAt;
  String title;
  String description;
  String url;
  String ticker;
  double sentiment;
  String lastPrice;

  Post(
      {this.publishedAt,
      this.title,
      this.description,
      this.url,
      this.ticker,
      this.sentiment,
      this.lastPrice});

  Post.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    ticker = json['ticker'];
    sentiment = json['sentiment'];
    lastPrice = json['lastPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['ticker'] = this.ticker;
    data['sentiment'] = this.sentiment;
    data['lastPrice'] = this.lastPrice;
    return data;
  }
}