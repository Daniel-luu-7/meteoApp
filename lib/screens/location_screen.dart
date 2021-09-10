import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/viewList.dart';
import 'package:clima/services/favorite_list.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  AssetImage weatherBackgroundImage = AssetImage('images/moon.jpg');
  IconData iconFavorite = Icons.favorite_border;

  String cityName;

  int temperature;
  int condition;
  String description;

  String dayJ1;
  int temperatureJ1;
  int conditionJ1;
  String descriptionJ1;

  String dayJ2;
  int temperatureJ2;
  int conditionJ2;
  String descriptionJ2;

  String dayJ3;
  int temperatureJ3;
  int conditionJ3;
  String descriptionJ3;

  String weatherIcon;
  String weatherMessage;

  int humidity;
  double windSpeed;
  int visibility;

  @override
  void initState() {
    super.initState();
    getDaysNumber();
    updateUI(widget.locationWeather);
  }

  IconData isFavorite() {
    if (FavoriteList.favoriteList.contains(cityName)) return (Icons.favorite);

    return (Icons.favorite_border);
  }

  void getDaysNumber() {
    var date = DateTime.now().weekday;

    dayJ1 = getDaysString(date + 1);
    dayJ2 = getDaysString(date + 2);
    dayJ3 = getDaysString(date + 3);
  }

  String getDaysString(int day) {
    switch (day % 7) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Sunday';
    }
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = '';
        weatherIcon = '';
        return;
      }

      iconFavorite = isFavorite();

      cityName = weatherData['city']['name'];
      condition = weatherData['list'][0]['weather'][0]['id'];
      weatherBackgroundImage = weather.getWeatherBackground(condition);

      double temp = weatherData['list'][0]['main']['temp'];
      temperature = temp.toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      description = weatherData['list'][0]['weather'][0]['description'];

      visibility = weatherData['list'][0]['visibility'];
      humidity = weatherData['list'][0]['main']['humidity'];
      windSpeed = weatherData['list'][0]['wind']['speed'];

      temp = weatherData['list'][7]['main']['temp'];
      temperatureJ1 = temp.toInt();
      conditionJ1 = weatherData['list'][7]['weather'][0]['id'];

      temp = weatherData['list'][15]['main']['temp'];
      temperatureJ2 = temp.toInt();
      conditionJ2 = weatherData['list'][15]['weather'][0]['id'];

      temp = weatherData['list'][23]['main']['temp'];
      temperatureJ3 = temp.toInt();
      conditionJ3 = weatherData['list'][23]['weather'][0]['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: weatherBackgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (iconFavorite == Icons.favorite_border) {
                              FavoriteList.favoriteList.add(cityName);
                              iconFavorite = Icons.favorite;
                            } else if (iconFavorite == Icons.favorite) {
                              FavoriteList.favoriteList.remove(cityName);
                              iconFavorite = Icons.favorite_border;
                            }
                          });
                        },
                        child: Icon(
                          iconFavorite,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewList();
                          }));
                        },
                        child: Icon(
                          Icons.visibility,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var enteredCity = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (enteredCity != null) {
                            var weatherData =
                                await weather.getCityWeather(enteredCity);
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 80.0,
                  endIndent: 80.0,
                  color: Colors.white,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 8.0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cityName,
                                    style: kMessageTextStyle,
                                  ),
                                  Text(
                                    '$temperature°',
                                    style: kTempTextStyle,
                                  ),
                                  Text(
                                    description,
                                    style: kDescription,
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WeatherJN(
                                      day: dayJ1,
                                      temperatureJ: temperatureJ1,
                                      weatherIcon: weatherIcon,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    WeatherJN(
                                      day: dayJ2,
                                      temperatureJ: temperatureJ2,
                                      weatherIcon: weatherIcon,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    WeatherJN(
                                      day: dayJ3,
                                      temperatureJ: temperatureJ3,
                                      weatherIcon: weatherIcon,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 8.0),
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WeatherInfoCard(
                              informationTitle: 'Humidity',
                              informationData: '$humidity%',
                            ),
                            VerticalDivider(
                              width: 5,
                              color: Colors.white,
                            ),
                            WeatherInfoCard(
                              informationTitle: 'Wind Speed',
                              informationData: '$windSpeed km/h',
                            ),
                            VerticalDivider(
                              width: 5,
                              color: Colors.white,
                            ),
                            WeatherInfoCard(
                              informationTitle: 'Visibility',
                              informationData: '${visibility / 1000} km',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherJN extends StatelessWidget {
  const WeatherJN({
    @required this.day,
    @required this.temperatureJ,
    @required this.weatherIcon,
  });

  final String day;
  final int temperatureJ;
  final String weatherIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$day',
          style: kWeatherJNDAy,
        ),
        Text(
          '$temperatureJ° $weatherIcon',
          style: kWeatherJNTempStyle,
        ),
      ],
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  WeatherInfoCard(
      {@required this.informationTitle, @required this.informationData});

  final String informationTitle;
  final String informationData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          informationData,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          informationTitle,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
