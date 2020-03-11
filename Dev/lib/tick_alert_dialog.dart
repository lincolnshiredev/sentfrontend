import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stockandsentiment/http_service.dart';

class TickAlertDialog extends StatefulWidget {
  Function setMainState;
  TickAlertDialog(this.setMainState);
  @override
  _TickAlertDialogState createState() => _TickAlertDialogState();
}

class _TickAlertDialogState extends State<TickAlertDialog> {
  static final _key = GlobalKey<FormState>();
  String ticker;
  bool isWaiting = false;

  //for invalid ticker
  dialogBox(BuildContext context) => Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            SizedBox(height: 170),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Invalid Ticker or already added",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  apiValidate(BuildContext context) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      ticker = ticker.toUpperCase();

      //Old Api Data
      String oldApi = await HttpService.getUrlLocally();
      Response oldApiResponse = await get(oldApi);
      final oldApiJson = json.decode(oldApiResponse.body);

      //New Api Data
      Response newApiResponse = await get("$oldApi,$ticker");
      final newApiJson = json.decode(newApiResponse.body);

      if (newApiJson.length == oldApiJson.length) {
        showDialog(
          context: context,
          builder: (context) {
            return dialogBox(context);
          },
        );
      } else {
        await HttpService.writeUrlLocalally(ticker);
        Navigator.pop(context);
        widget.setMainState();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          SizedBox(height: 80),
          Stack(
            children: <Widget>[
              
              Container(
                height: 250,
                decoration: BoxDecoration(
                      boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(4, 4),
                            blurRadius: 2,
                          )
                        ],
                  color:  Colors.blueGrey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Add Stock Ticker",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "eg msft",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(4, 4),
                            blurRadius: 2,
                          )
                        ],
                        color: Color(0xFF1B1E28),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Form(
                        key: _key,
                        child: TextFormField(
                          onSaved: (value) {
                            ticker = value;
                          },
                          validator: (tick) {
                            if (tick.isEmpty || tick.contains(',')) {
                              return "Enter a valid stock ticker";
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter here ...",
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            errorStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            setState(() {
                              isWaiting = true;
                            });
                            await apiValidate(context);
                            setState(() {
                              isWaiting = false;
                            });
                          },
                          child: Text("Ok"),
                        )
                      ],
                    )
                  ],
                ),
              ),
              isWaiting
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 250,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
