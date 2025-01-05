import 'package:flutter/material.dart';
import 'package:weather_ch2/services/weather_service.dart';
import '../model/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('23474f85c62938615d08f2d30942d65e  ');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

  try{
  final weather = await _weatherService.getWeather(cityName);
  setState(() {
  _weather = weather;
  });
  }

  catch(e) {
  print(e);
  }
}
  // weather animation


  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading City..."),

            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}