import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/ui/weather/PagerIndicator.dart';

class WeatherScreen extends StatefulWidget {
  final int weatherIndex;
  final List<Weather> weathers;

  //init
  WeatherScreen(
    this.weatherIndex, 
    this.weathers
  );

  @override
  State<StatefulWidget> createState() {
    return WeatherScreenState(weatherIndex, weathers);
  }
}

class WeatherScreenState extends State with TickerProviderStateMixin {
  int weatherIndex;
  List<Weather> weathers;

  WeatherScreenState(
    this.weatherIndex, 
    this.weathers
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          "Detail",
          style: TextStyle(),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          pageViewWidget(),
          Container(
            margin: EdgeInsets.only(
              bottom: 44,
            ),
            child: PagerIndicator(
              itemCount: weathers.length,
              indicatorNormalColor: Color.fromRGBO(230, 224, 211, 1),
              indicatorSelectedColor: Colors.red,
              indicatorPadding: 6,
              indicatorSize: 9,
              currentSelected: weatherIndex,
            ),
          ),
        ],
      ),
    );
  }

  Widget pageViewWidget() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return itemPageViewWidget(weathers[index]);
      },
      itemCount: weathers.length,
      controller: PageController(
        initialPage: weatherIndex,
      ),
      onPageChanged: (currentPosition) {
        setState(() {
          weatherIndex = currentPosition;
        });
      },
    );
  }

  Widget itemPageViewWidget(Weather weather) {
    return Hero(
      tag: "hero tag container ${weather.location}",
      child: Card(
        elevation: 10,
        margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: ListView(
            children: <Widget>[
              // header
              Container(
                margin: EdgeInsets.fromLTRB(36, 36, 0, 24),
                child: Hero(
                  tag: "hero tag ${weather.location}",
                  child: Container(
                    width: 200,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "${weather.location}",
                        style: TextStyle(
                          fontSize: 44,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // main
              ListTile(
                leading: leadingMainWidget(weather),
                title: Hero(
                  tag: "hero tag ${weather.location} main",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${weather.main}",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                subtitle: Text("${weather.des}",style: TextStyle(color: Colors.white)),
              ),

              detailWidget(
                AssetImage("images/temp.png"),
                Text("${weather.temp.toInt()}°C",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),  

              detailWidget(
                AssetImage("images/pressure.png"),
                Text("${weather.pressure.toInt()} hPa",style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
              ),
              detailWidget(
                AssetImage("images/humidity.png"),
                Text("${weather.humidity.toInt()} %",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leadingMainWidget(Weather weather) {
    if (weather.temp.toInt() < 20 && weather.temp.toInt() > 10) {
      return Container(
        height: 64,
        width: 64,
        child: Image(
          image: AssetImage(
            "images/cloud.png",
          ),
          color: Colors.white,
        ),
      );
    } else if (weather.temp.toInt() < 10) {
      return Container(
        height: 64,
        width: 64,
        child: Image(
          image: AssetImage("images/snowing.png"),
          color: Colors.blue,
        ),
      );
    } else {
      return Container(
        height: 64,
        width: 64,
        child: Image(
          image: AssetImage("images/cloudy.png"),
          color: Colors.yellow,
        ),
      );
    }
  }

  Widget detailWidget(ImageProvider image, Widget title) {
    return ListTile(
      leading: Container(
        height: 24,
        width: 24,
        child: Image(
          image: image,
          color: Colors.white,
        ),
      ),
      title: title,
    );
  }
}
