import 'package:flutter/material.dart';

const colorPrimary = Color(0xff953f62);
const colorPrimaryLight = Color(0xffbd4753);
const colorAccent = Color(0xffeb4c46);
const colorAccentLight = Color(0xfff85d3f);
const colorAccentLighter = Color(0xffcb8262);

const colorSecondaryDark = Color(0xff571d1b);
const colorSecondary = Color(0xff782e2b);
const colorSecondaryLight = Color(0xff873d3a);
const colorSecondaryLighter = Color(0xff954b4c);

const kTempTextStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontSize: 70.0,
  fontWeight: FontWeight.w100,
);

const kStatsTextStyle = TextStyle(
  fontFamily: 'Baloo',
  fontSize: 22.0,
);

const kStatsValuesTextStyle = TextStyle(
  fontFamily: 'Baloo',
  fontSize: 20.0,
);

const kConditionTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.w300,
);

const kCityTextStyle = TextStyle(
  fontFamily: 'Baloo',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Quicksand',
  fontWeight: FontWeight.bold,
);

const kDateTextStyle = TextStyle(
  fontFamily: 'Baloo',
  fontWeight: FontWeight.w300,
  fontSize: 20,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_on,
    color: Colors.white,
  ),
  hintText: 'Enter city name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(3.0),
    ),
    borderSide: BorderSide.none,
  ),
);
