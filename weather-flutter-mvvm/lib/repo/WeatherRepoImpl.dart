import 'dart:async';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:weather_flutter/service/local/WeatherDao.dart';
import 'package:weather_flutter/service/remote/WeatherApi.dart';

class WeatherRepoImpl with WeatherRepo {

  // // static instance
  // static WeatherRepo _instance;

  // static WeatherRepo getInstance() {
  //   if (_instance == null) {
  //     _instance = WeatherRepoImpl();
  //   }
  //   return _instance;
  // }

  // private properties
  WeatherApi _weatherApi = WeatherApi();
  WeatherDao _weatherDao = WeatherDao();

  @override
  Future<Weather> getWeatherByLocation(String location) async {
    Weather weather = await _weatherApi.findWeatherByLocation(location);
    Weather weatherLocal = await _weatherDao.getWeatherByLocation(location);

    if (weatherLocal == null && weather != null) {
      await _weatherDao.saveWeather(weather);
      return weather;
    }

    if (weatherLocal == null && weather == null) {
      return null;
    }

    if (weatherLocal != null && weather == null) {
      return weatherLocal;
    }

    if (weatherLocal != null && weather != null) {
      weather.favorite = weatherLocal.favorite;
      await _weatherDao.saveWeather(weather);
      return weather;
    }

    return null;
  }

  @override
  Future<List<Weather>> getWeathers() {
    return _weatherDao.getWeathers();
  }

  @override
  Future<void> removeWeather(Weather weather) {
    return _weatherDao.removeWeather(weather);
  }

  @override
  Future<void> saveWeather(Weather weather) {
    return _weatherDao.saveWeather(weather);
  }

  @override
  Future<List<Weather>> getWeathersFavorite() {
    return _weatherDao.getWeathersFavorite();
  }
}
