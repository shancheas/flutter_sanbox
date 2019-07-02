import 'package:flutter/material.dart';
import 'package:sanbox/services/api_services.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'services/models/wheaters_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Weather weather;
  int cityId = 1047378;

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather({bool force = true}) async {
    print('force $force');
    apiService.fetchWheater(cityId, force: force).then((response) {
      setState(() {
        weather = response;
      });
    });
  }

  _setCity(int id) {
    cityId = id;
    // _refreshIndicatorKey.currentState.show();
    _getWeather(force: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text(widget.title), actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: _setCity,
            itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                  const PopupMenuItem<int>(
                    value: 1047378,
                    child: Text('Jakarta'),
                  ),
                  const PopupMenuItem<int>(
                    value: 44418,
                    child: Text('London'),
                  ),
                  const PopupMenuItem<int>(
                    value: 2459115,
                    child: Text('New York'),
                  ),
                ],
          ),
        ]),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _getWeather,
            child: ListView(
              children: <Widget>[
                weather == null
                    ? Center(child: CircularProgressIndicator())
                    : WeatherCard(weather: weather)
              ],
            )));
  }
}

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({Key key, this.weather}) : super(key: key);
  String srcImage(String condition) {
    return 'https://www.metaweather.com/static/img/weather/png/64/$condition.png';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Today Wheater',
                  style:
                      TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
            )),
            CachedNetworkImage(
              imageUrl: srcImage(weather.condition),
              errorWidget: Icon(Icons.wb_cloudy),
            ),
            WeatherRow(title: 'Location', text: weather.location),
            WeatherRow(
                title: 'Temp', text: '${weather.temp.toStringAsFixed(1)}°C'),
            WeatherRow(
                title: 'Max Temp',
                text: '${weather.maxTemp.toStringAsFixed(1)}°C'),
            WeatherRow(
                title: 'Min Temp',
                text: '${weather.minTemp.toStringAsFixed(1)}°C'),
            WeatherRow(
                title: 'Last Update',
                text: weather.lastUpdated.toLocal().toString()),
          ],
        ),
      ),
    );
    ;
  }
}

class WeatherRow extends StatelessWidget {
  final String title;
  final String text;

  const WeatherRow({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text(title), Text(text)],
        ),
        Divider()
      ],
    );
  }
}
