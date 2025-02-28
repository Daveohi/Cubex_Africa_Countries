import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String officialName;
  final String capital;
  final String flag;
  final Map<String, String> languages;
  final int population;
  final double area;
  final String region;
  final List<String> timezones;

  const Country({
    required this.officialName,
    required this.capital,
    required this.flag,
    required this.languages,
    this.population = 0,
    this.area = 0,
    this.region = '',
    this.timezones = const [],
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      officialName: json['name']['official'] ?? '',
      capital: (json['capital'] as List?)?.first ?? 'N/A',
      flag: json['flags']['png'] ?? '',
      languages: Map<String, String>.from(json['languages'] ?? {}),
      population: json['population'] ?? 0,
      area: (json['area'] ?? 0).toDouble(),
      region: json['region'] ?? '',
      timezones: List<String>.from(json['timezones'] ?? []),
    );
  }

  @override
  List<Object?> get props => [officialName];
}
