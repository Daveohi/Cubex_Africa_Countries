import 'package:africa_countries/data/models/countrymodels.dart';
import 'package:africa_countries/data/repositories/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_details_state.dart';

class CountryDetailsCubit extends Cubit<CountryDetailsState> {
  final CountryRepository _repository;

  CountryDetailsCubit(this._repository) : super(CountryDetailsInitial());

  Future<void> loadCountryDetails(String countryName) async {
    emit(CountryDetailsLoading());
    try {
      final country = await _repository.getCountryDetails(countryName);
      emit(CountryDetailsLoaded(country));
    } catch (e) {
      emit(CountryDetailsError(e.toString()));
    }
  }
}
