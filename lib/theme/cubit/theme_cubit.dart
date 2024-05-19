import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_weather_app/weather/models/weather.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import "package:weather_repository/src/model/weather.dart" show WeatherCondition;

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<Color> {
  static const defaultColor = Colors.blue;
  ThemeCubit() : super(defaultColor);

  void updateTheme(Weather weather) {
    emit(weather.toColor);
  }
  
  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(int.parse(json['color'] as String));
  }
  
  @override
  Map<String, dynamic>? toJson(Color state) {
    return <String, dynamic>{'color': state.value};
  }
}

extension on Weather {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.yellow;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.unknown:
        return ThemeCubit.defaultColor;
    }
  }
}