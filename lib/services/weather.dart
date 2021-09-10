import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

const apiKey = 'e279ad1b300bcb685d120cabdfe6d3fc';
const openWeatherMapURLForecast =
    'https://api.openweathermap.org/data/2.5/forecast';
const openWeatherMapURLWeather =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        '$openWeatherMapURLForecast?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getFavoriteCityWeather(String cityName) async {
    var url =
        '$openWeatherMapURLWeather?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURLForecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  AssetImage getWeatherBackground(int condition) {
    if (condition < 233) {
      //thunderstorm
      return AssetImage('images/afternoon.png');
    } else if (condition < 322) {
      //drizzle
      return AssetImage('images/night1.png');
    } else if (condition < 532) {
      //rain
      return AssetImage('images/sun.png');
    } else if (condition < 622) {
      //snow
      return AssetImage('images/night1.png');
    } else if (condition < 781) {
      //atmosphere
      return AssetImage('images/nature2.png');
    } else if (condition == 800) {
      //clear
      return AssetImage('images/night1.png');
    } else if (condition <= 804) {
      //clouds
      return AssetImage('images/night1.png');
    } else {
      return AssetImage('images/us.jpg');
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
