//Package Imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

//In File Imports
import '../blocs/root_bloc/root_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<TargetFocus> targets = List();

  GlobalKey stockPrices = GlobalKey();
  GlobalKey fab = GlobalKey();
  GlobalKey noTickers = GlobalKey();
  GlobalKey enterTicker = GlobalKey();
  GlobalKey enterOk = GlobalKey();
  GlobalKey delete = GlobalKey();

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: stockPrices,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Stock Prices",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "This screen contains stock data on the tickers you have added.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: noTickers,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "There are no tickers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Tap to add some tickers",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: fab,
        contents: [
          ContentTarget(
            align: AlignContent.top,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Click here to add a ticker",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: enterTicker,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter a ticker eg MSFT or msft",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 5",
        keyTarget: enterOk,
        contents: [
          ContentTarget(
            align: AlignContent.top,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Press Ok to add",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 6",
        keyTarget: delete,
        contents: [
          ContentTarget(
            align: AlignContent.top,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Press to remove",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
  }

  void showTutorial() {
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.red,
      alignSkip: AlignmentGeometry.lerp(
          Alignment.bottomCenter, Alignment.bottomLeft, 3),
      paddingFocus: 10,
      opacityShadow: 0.9,
      finish: () {
        BlocProvider.of<RootBloc>(context).add(AppStarted());
      },
      clickTarget: (target) {
        print(target.identify);
        if (target.identify == "Target 3") {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialogBoxDummy;
            },
          );
        } else if (target.identify == "Target 5") {
          Navigator.pop(context);
          setState(() {
            _card = msftCard;
          });
        }
      },
    )..show();
  }

  Widget get dialogBoxDummy => Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            SizedBox(height: 80),
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
                color: Colors.blueGrey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add Stock ticker",
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
                    child: TextFormField(
                      key: enterTicker,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      initialValue: 'msft',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                      ),
                      RaisedButton(
                        key: enterOk,
                        onPressed: () {},
                        child: Text("Ok"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 100), () {
      showTutorial();
    });
  }

  @override
  void initState() {
    initTargets();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  Widget get _body => Center(
        child: Text(
          "No stock \n tickers found",
          key: noTickers,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      );

  Widget get msftCard => Column(
        children: <Widget>[
          Container(
            child: Card(
              color: Color(0xFF1B1E28),
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                    border: Border(
                      right: BorderSide(color: Colors.green, width: 15),
                    ),
                  ),
                  child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              child: Text(
                                'M',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'MSFT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Microsoft Corporation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          SizedBox(height: 7.0),
                          Text(
                            "Price: \$153.63",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "-4.53 %",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 30.0),
                          InkWell(
                            key: delete,
                            onTap: () {},
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      floatingActionButton: new FloatingActionButton(
        key: fab,
        backgroundColor: Color(0xFF1B1E28),
        onPressed: () {},
        child: new Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Stock Prices",
          key: stockPrices,
        ),
      ),
      body: _card ?? _body,
    );
  }
}
