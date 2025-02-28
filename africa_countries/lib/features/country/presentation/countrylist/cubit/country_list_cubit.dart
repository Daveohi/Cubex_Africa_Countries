import 'package:africa_countries/data/repositories/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/countrymodels.dart';

part 'country_list_state.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final CountryRepository _repository;

  CountryListCubit(this._repository) : super(CountryListInitial());

  Future<void> fetchCountries() async {
    emit(CountryListLoading());
    try {
      final countries = await _repository.getAfricanCountries();

      // Add sorting logic here
      countries.sort(
          (b, a) => b.officialName.compareTo(a.officialName)); // Descending

      emit(CountryListLoaded(countries));
    } catch (e) {
      emit(CountryListError(e.toString()));
    }
  }
}
