import 'package:flutter/material.dart';

class StockInfo extends StatelessWidget {
final Map<String, dynamic> data;

  StockInfo({this.data});

 final TextStyle _textStyle = TextStyle(
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
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Sentiment Score: ${data['sentiment']}",
                    style: _textStyle,
                  ),
                  Text(
                    "Price: \$${data['price']}",
                    style: _textStyle,
                  ),
                  Text(
                    "${data['numberOfArticles']} Articles",
                    style: _textStyle,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
