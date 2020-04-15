class AdditionalData {
  int numberOfArticles;
  double overallSentiment;
  String avgSentiment;

  AdditionalData({
    this.avgSentiment,
    this.numberOfArticles,
    this.overallSentiment,
  });

  factory AdditionalData.fromJson(Map<String, dynamic> json) {
    return AdditionalData(
      numberOfArticles: json["numberOfArticles"],
      overallSentiment: json["overallSentiment"].toDouble(),
      avgSentiment: json["avgSentiment"],
    );
  }
}
