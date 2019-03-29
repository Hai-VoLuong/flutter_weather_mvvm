import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:weather_flutter/repo/WeatherRepoImpl.dart';

class HistoryViewModel extends Model {

  // static instance
  static HistoryViewModel _instance;

  static HistoryViewModel getInstance() {
    if (_instance == null) {
      _instance = HistoryViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  // private properties
  WeatherRepo _weatherRepo = WeatherRepoImpl();

  // public properties
  List<Weather> weathers = [];

  // init
  HistoryViewModel() {
    updateWeather();
  }

  // public func
  void updateWeather() async {
    weathers = await _weatherRepo.getWeathers();
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    notifyListeners();
    await _weatherRepo.saveWeather(weather);
  }

  void deleteWeather(Weather weather) async {
    await _weatherRepo.removeWeather(weather);
    updateWeather();
  }
}
