import './articles_model.dart';
import './additional_data_model.dart';

class Stock {
  List<Articles> articles;
  AdditionalData additionalData;

  Stock({this.additionalData, this.articles});

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        additionalData: AdditionalData.fromJson(json["additionalData"]),
        articles: List<Articles>.from(json["articles "].map((articles) {
          return Articles.fromJson(articles);
        }).toList()),
      );
}
