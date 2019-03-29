import 'package:flutter/material.dart';
import 'package:weather_flutter/ui/home/HomeScreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Demo",
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: HomeScreen(),
      // routes: <String, WidgetBuilder>{
      //   '/pageTwo': (BuildContext context) => MyPageTwo(title: 'Page two'),
      // },
    ),
  );
}

