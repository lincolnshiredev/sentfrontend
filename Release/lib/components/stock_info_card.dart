import 'package:flutter/material.dart';
import 'package:stockandsentiment/models/stock_info_model.dart';

class StockInfo extends StatelessWidget {
  StockInfoModel stockInfoModel;
  StockInfo({this.stockInfoModel});

  TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 21,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1B1E28),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ClipPath(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(64, 75, 96, .9),
            border: Border(
              right: BorderSide(
                  color: (double.parse(stockInfoModel.sentiment) < 0.00) != null
                      ? Colors.green
                      : Colors.red,
                  width: 15),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 125.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    stockInfoModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Sentiment Score: ${stockInfoModel.sentiment}",
                      style: _textStyle,
                    ),
                    Text(
                      "Price: \$${stockInfoModel.price}",
                      style: _textStyle,
                    ),
                    Text(
                      "${stockInfoModel.numberOfArticles} Articles",
                      style: _textStyle,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
