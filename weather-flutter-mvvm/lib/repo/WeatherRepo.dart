
import 'dart:async';
import 'package:weather_flutter/model/Weather.dart';

abstract class WeatherRepo {

  Future<Weather> getWeatherByLocation(String location);

  Future<void> removeWeather(Weather weather);

  Future<void> saveWeather(Weather weather);

  Future<List<Weather>> getWeathers();

  Future<List<Weather>> getWeathersFavorite();

}