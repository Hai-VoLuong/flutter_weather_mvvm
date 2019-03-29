import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:weather_flutter/repo/WeatherRepoImpl.dart';

class HomeViewModel extends Model {

  // static instance
  static HomeViewModel _instance;
  static HomeViewModel getInstance() {
    if (_instance == null) {
      _instance = HomeViewModel();
    }
    return _instance;
  }

  // public properties
  List<Weather> weatherFavorite = [];

  // private properties
  WeatherRepo _weatherRepo = WeatherRepoImpl();

  // init
  HomeViewModel() {
    updateWeatherFavorite();
  }

  // public func
  void updateWeatherFavorite() async {
    weatherFavorite = await _weatherRepo.getWeathersFavorite();
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    await _weatherRepo.saveWeather(weather);
    updateWeatherFavorite();
  }

  void deleteWeather(Weather weather) async {
    await _weatherRepo.removeWeather(weather);
    updateWeatherFavorite();
  }
}
