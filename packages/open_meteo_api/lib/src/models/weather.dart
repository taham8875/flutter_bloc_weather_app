class Weather {
  final double temperature;
  final int weathercode;

  Weather({required this.temperature, required this.weathercode});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'] as double,
      weathercode: json['weathercode'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temperature'] = temperature;
    data['weathercode'] = weathercode;
    return data;
  }
}
