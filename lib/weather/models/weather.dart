import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import 'package:weather_repository/src/model/weather.dart' as weather_repository_model;

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

class Temperature extends Equatable {
  final double value;

  const Temperature({required this.value});

  factory Temperature.fromFahrenheit(double fahrenheit) {
    return Temperature(value: fahrenheit);
  }

  @override
  List<Object> get props => [value];
}

class Weather extends Equatable {
  final weather_repository_model.WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final Temperature temperature;

  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
  });

  factory Weather.fromRepository(weather_repository_model.Weather weather) {
    return Weather(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: Temperature(value: weather.temperature),
    );
  }

  static final empty = Weather(
    condition: weather_repository_model.WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    location: '--',
  );

  @override
  List<Object> get props => [condition, lastUpdated, location, temperature];

  Weather copyWith({
    weather_repository_model.WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    Temperature? temperature,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}
