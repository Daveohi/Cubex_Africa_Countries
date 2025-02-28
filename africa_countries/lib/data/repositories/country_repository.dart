import 'package:dio/dio.dart';

import '../../core/constants/app_constants.dart';
import '../models/countrymodels.dart';

class CountryRepository {
  final Dio _dio = Dio();

  Future<List<Country>> getAfricanCountries() async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/region/africa',
        queryParameters: {
          'fields':
              'name,capital,languages,flags,population,area,region,timezones'
        },
      );
      return (response.data as List).map((e) => Country.fromJson(e)).toList();
    } on DioException catch (_) {
      throw Exception('Failed to load countries: Connection Error');
    }
  }

  Future<Country> getCountryDetails(String name) async {
    try {
      final response = await _dio.get('${AppConstants.baseUrl}/name/$name');
      return Country.fromJson(response.data[0]);
    } on DioException catch (_) {
      throw Exception('Failed to load country details: Connection Error');
    }
  }
}
