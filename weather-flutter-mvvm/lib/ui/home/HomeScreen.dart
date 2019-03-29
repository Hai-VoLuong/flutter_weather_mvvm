import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/ui/WeatherItemCell.dart';
import 'package:weather_flutter/ui/history/HistoryScreen.dart';
import 'package:weather_flutter/ui/home/HomeViewModel.dart';
import 'package:weather_flutter/ui/search/SearchScreen.dart';
import 'package:weather_flutter/ui/weather/WeatherScreen.dart';

class HomeScreen extends StatelessWidget {
  Widget historyWidget() {
    return ScopedModelDescendant<HomeViewModel>(
      builder: (BuildContext context, Widget child, HomeViewModel model) {
        return IconButton(
          icon: Icon(Icons.history),
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HistoryScreen();
                },
              ),
            );
            if (result != null) {
              model.updateWeatherFavorite();
            }
          },
        );
      },
    );
  }

  Widget searchWidget(BuildContext context) {
    return ScopedModelDescendant<HomeViewModel>(
      builder: (BuildContext context, Widget child, HomeViewModel model) {
        return IconButton(
          icon: Icon(Icons.search),
          onPressed: () => onPress(context, model),
        );
      },
    );
  }

  Widget listFavoriteWeatherWidget() {
    return ScopedModelDescendant<HomeViewModel>(
      builder: (BuildContext context, Widget child, HomeViewModel model) {
        return ListView.builder(
          itemCount: model.weatherFavorite.length,
          itemBuilder: (context, index) {
            return WeatherItemCell(
              weather: model.weatherFavorite[index],
              onClick: (weather) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WeatherScreen(
                        model.weatherFavorite.indexOf(weather),
                        model.weatherFavorite,
                      );
                    },
                  ),
                );
              },
              onFavorite: (weather) {
                model.updateFavorite(weather);
              },
              onDelete: (weather) {
                model.deleteWeather(weather);
              },
              isDelete: true,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: HomeViewModel.getInstance(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Weather"),
          actions: <Widget>[
            searchWidget(context),
            historyWidget(),
          ],
        ),
        body: listFavoriteWeatherWidget(),
      ),
    );
  }

  void onPress(BuildContext context, HomeViewModel model) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchScreen(),
      ),
    );
    if (result != null) {
      model.updateWeatherFavorite();
    }
  }
}
