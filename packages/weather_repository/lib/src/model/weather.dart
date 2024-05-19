import 'package:equatable/equatable.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}
class Weather extends Equatable {
  final String location;
  final double temperature;
  final WeatherCondition condition;

  const Weather({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: json['location'] as String,
      temperature: json['temperature'] as double,
      condition: json['condition'] as WeatherCondition,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['temperature'] = temperature;
    data['condition'] = condition;
    return data;
  }

  @override
  List<Object> get props => [location, temperature, condition];
}