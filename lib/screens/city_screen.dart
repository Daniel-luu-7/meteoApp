import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/favorite_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  WeatherModel weather = WeatherModel();
  List<FavoriteCityCard> listFavoriteCities = [];

  String cityName;

  void getFavoriteCitiesList() async {
    FavoriteList.favoriteList.sort();

    for (String city in FavoriteList.favoriteList) {
      var weatherData = await weather.getFavoriteCityWeather(city);

      double temp = weatherData['main']['temp'];
      int temperature = temp.toInt();
      int condition = weatherData['weather'][0]['id'];

      var newItem = FavoriteCityCard(
        cityName: city,
        temperature: temperature,
        icon: weather.getWeatherIcon(condition),
      );

      setState(() {
        listFavoriteCities.add((newItem));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFavoriteCitiesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nature.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7),
                BlendMode.dstATop,
              ),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: kTextFieldInputDecoration,
                      onChanged: (value) {
                        cityName = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(color: Colors.white),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, cityName);
                        },
                        child: Text(
                          'Get Weather',
                          style: kButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Favoris',
                              textStyle: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Comfortaa',
                              ),
                              speed: const Duration(milliseconds: 300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: listFavoriteCities,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteCityCard extends StatelessWidget {
  const FavoriteCityCard(
      {@required this.cityName,
      @required this.temperature,
      @required this.icon});

  final String cityName;
  final int temperature;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, cityName);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 60.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  cityName,
                  style: kWeatherJNTempStyle,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kWeatherJNTempStyle,
                    ),
                    Text(icon),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedList extends StatelessWidget {
  const AnimatedList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(30),
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return FavoriteCityCard(
          cityName: 'Paris',
          temperature: 25,
          icon: 'F',
        );
      },
    );
  }
}
