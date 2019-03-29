import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/repo/WeatherRepo.dart';
import 'package:weather_flutter/repo/WeatherRepoImpl.dart';

class SearchViewModel extends Model {

  // static instance
  static SearchViewModel _instance;

  static SearchViewModel getInstance() {
    if (_instance == null) {
      _instance = SearchViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  // private properties
  WeatherRepo _weatherRepo = WeatherRepoImpl();

  // public properties
  Weather weatherSearched;
  bool isLoadingLocation = false;

  // public func
  void getWeatherByLocation(String location) async {
    isLoadingLocation = true;
    notifyListeners();
    weatherSearched = await _weatherRepo.getWeatherByLocation(location);
    isLoadingLocation = false;
    notifyListeners();
  }

  void favorite() async {
    weatherSearched.favorite = !weatherSearched.favorite;
    notifyListeners();
    await _weatherRepo.saveWeather(weatherSearched);
  }
}
