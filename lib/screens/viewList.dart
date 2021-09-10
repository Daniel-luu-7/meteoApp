import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Go Back"),
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      body: AnimatedList(),
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
        return AnimationConfiguration.staggeredList(
          position: index,
          delay: Duration(milliseconds: 100),
          child: SlideAnimation(
            duration: Duration(milliseconds: 2500),
            curve: Curves.fastLinearToSlowEaseIn,
            verticalOffset: -250,
            child: ScaleAnimation(
              duration: Duration(milliseconds: 1500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FavoriteCityCard(
                cityName: 'Paris',
                temperature: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FavoriteCityCard extends StatelessWidget {
  const FavoriteCityCard({
    @required this.cityName,
    @required this.temperature,
  });

  final String cityName;
  final int temperature;

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
