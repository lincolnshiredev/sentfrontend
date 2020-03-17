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
}
