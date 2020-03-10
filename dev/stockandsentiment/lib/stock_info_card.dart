import 'package:flutter/material.dart';

class StockInfo extends StatelessWidget {
  Map<String, dynamic> data;

  StockInfo({this.data});

  //Declared textstyle so I can use it, In down three places without repeating it again.
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
                 color: (double.parse(data['sentiment']) < 0) != null ? Colors.red : Colors.green,
                  width: 15),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container( width: 125.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    data['image'],
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
                      "Sentiment Score: ${data['sentiment']}",
                      style: _textStyle,
                    ),
                    Text(
                      "\$${data['price']}",
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
        clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
      ),
    );
  }
}
