import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter/model/Weather.dart';
import 'package:weather_flutter/ui/WeatherItemCell.dart';
import 'package:weather_flutter/ui/history/HistoryViewModel.dart';
import 'package:weather_flutter/ui/weather/WeatherScreen.dart';

class HistoryScreen extends StatelessWidget {

  Widget weathersWidget() {
    return ScopedModelDescendant<HistoryViewModel>(
      builder: (BuildContext context, Widget child, HistoryViewModel model) {
        return ListView.builder(
          itemCount: model.weathers.length,
          itemBuilder: (context, index) {
            return WeatherItemCell(
              onFavorite: (Weather weather) {
                model.updateFavorite(weather);
              },
              onClick: (Weather weather) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WeatherScreen(
                        model.weathers.indexOf(weather),
                        model.weathers,
                      );
                    },
                  ),
                );
              },
              weather: model.weathers[index],
              onDelete: (Weather weather) {
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
      model: HistoryViewModel.getInstance(),
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Text("History"),
          ),
          body: weathersWidget(),
        ),
        onWillPop: () {
          Navigator.pop(context, "pop from history screen");
          HistoryViewModel.destroyInstance();
        },
      ),
    );
  }
}
