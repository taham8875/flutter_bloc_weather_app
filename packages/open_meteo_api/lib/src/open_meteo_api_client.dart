import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:open_meteo_api/src/models/location.dart';
import 'package:open_meteo_api/src/models/weather.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class OpenMeteoApiClient {
  final Dio _dio = Dio();
  OpenMeteoApiClient();

  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';


  /// Finds a [Location] `/v1/search/?name=(query)`.
  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );

    final locationResponse = await _dio.get(locationRequest.toString());

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    // dio returns a Map<String, dynamic> when the response is JSON
    final  locationJson = locationResponse.data;

    if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

    final results = locationJson['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  /// Fetches [Weather] for a given [latitude] and [longitude].
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });

    final weatherResponse = await _dio.get(weatherRequest.toString());

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    // dio returns a Map<String, dynamic> when the response is JSON
    final bodyJson = weatherResponse.data;

    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  }
}