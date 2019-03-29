import 'package:flutter/material.dart';
import 'package:weather_flutter/model/Weather.dart';

class WeatherItemCell extends StatelessWidget {
  final Weather weather;
  final Function(Weather weather) onClick;
  final Function(Weather weather) onFavorite;
  final Function(Weather weather) onDelete;
  final bool isDelete;

  WeatherItemCell({
    this.weather,
    this.onClick,
    this.onFavorite,
    this.onDelete,
    this.isDelete
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "hero tag container ${weather.location}",
      child: Card(
        elevation: 10,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: ListTile(
            onTap: () {
              onClick(weather);
            },
            onLongPress: () {
              if (isDelete)
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Delete ${weather.location}?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          onPressed: () {
                            onDelete(weather);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Yes",
                          ),
                        ),
                      ],
                    );
                  },
                );
            },
            leading: leadingMainWidget(weather),
            trailing: favoriteWidget(),
            isThreeLine: true,
            title: Hero(
              tag: "hero tag ${weather.location}",
              child: Container(
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${weather.location}",
                    style: TextStyle(fontSize: 26, color: Colors.white ,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  child: Material(
                    color: Colors.transparent,
                    child: Text("${weather.main}",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                  ),
                  tag: "hero tag ${weather.location} main",
                ),
                Hero(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${weather.temp.toInt()}°C",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  tag: "hero tag ${weather.location} temp",
                )
              ],
            ),
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

  Widget favoriteWidget() {
    return IconButton(
      icon: weather.favorite
          ? Icon(
              Icons.favorite,
              color: Colors.redAccent,
            )
          : Icon(
              Icons.favorite,
              color: Colors.white,
            ),
      onPressed: () {
        onFavorite(weather);
      },
    );
  }
}
