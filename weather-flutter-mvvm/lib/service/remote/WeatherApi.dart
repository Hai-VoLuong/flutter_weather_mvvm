import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/utils/NetworkUtil.dart';

class WeatherApi {
  var client = Client();

  Future<Weather> findWeatherByLocation(String location) async {
    String url =
        "$BASE_URL/$WEATHER?$QUERY_PARAM=$location&$APP_ID_PARAM=$APP_ID";
    var response;
    try {
      response = await client.get(url);
    } on Exception {
      print("client exception");
      return null;
    }
    if (response.statusCode == 200) {
      print(response.body);
      WeatherFromApi weatherFromApi;
      try {
        weatherFromApi = WeatherFromApi.fromJson(json.decode(response.body));
      } on FormatException {
        print("json format exception");
      }
      return weatherFromApi?.weather();
    } else {
      print("request error: ${response.body}");
      return null;
    }
  }
}

// map WeatherFromApi
class WeatherFromApi {
  int id;
  String name;
  Main main;
  List<WeatherData> weathers;

  WeatherFromApi({this.id, this.name, this.main});

  WeatherFromApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    main = Main.fromJson(json['main']);
    weathers = [];
    for (var value in json['weather']) {
      weathers.add(WeatherData.fromJson(value));
    }
  }

  Weather weather() {
    return Weather(
        id,
        name,
        weathers[0]?.main,
        weathers[0]?.description,
        main?.temp,
        main?.pressure,
        main?.humidity,
        main?.tempMin,
        main?.tempMax,
        DateTime.now().millisecondsSinceEpoch
    );
  }
}

// map weather
class WeatherData {
  String main;
  String description;

  WeatherData(this.main, this.description);

  WeatherData.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    description = json['description'];
  }
}

// map main
class Main {
  num temp;
  num pressure;
  num humidity;
  num tempMin;
  num tempMax;

  Main(this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }
}
