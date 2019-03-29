import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_flutter/ui/home/HomeScreen.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Demo",
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: SampleAppPage(title: 'Sample app'),
      routes: <String, WidgetBuilder>{
        //'/pageTwo': (BuildContext context) => MyPageTwo(title: 'Page two'),
      },
    ),
  );
}

class SampleAppPage extends StatefulWidget {
  final String title;
  SampleAppPage({Key key, this.title}) : super(key: key);
  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }

  Widget getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  Widget getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int index) {
        return getRow(index);
      }
    );
  }

  Widget getRow(int item) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text("Row ${widgets[item]["title"]}"),
    );
  }

  getBody() {
    if (widgets.length == 0) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: getBody()
    );
  }
}
