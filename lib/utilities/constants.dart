import 'package:flutter/material.dart';

const kMessageTextStyle = TextStyle(
  fontFamily: 'Comfortaa',
  fontSize: 30.0,
);

const kTempTextStyle = TextStyle(
  fontFamily: 'Comfortaa',
  fontSize: 100.0,
);

const kDescription = TextStyle(
  fontFamily: 'Comfortaa',
  fontSize: 20.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Comfortaa',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kWeatherJNDAy = TextStyle(
  fontSize: 15,
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.bold,
);

const kWeatherJNTempStyle = TextStyle(
  fontSize: 25,
  fontFamily: 'Comfortaa',
);

const kWeatherJNDescriptionStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Comfortaa',
);

const kTextFieldInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter a city name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
