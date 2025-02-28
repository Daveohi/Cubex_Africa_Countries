part of 'country_list_cubit.dart';

abstract class CountryListState extends Equatable {
  const CountryListState();

  @override
  List<Object> get props => [];
}

class CountryListInitial extends CountryListState {}

class CountryListLoading extends CountryListState {}

class CountryListLoaded extends CountryListState {
  final List<Country> countries;
  const CountryListLoaded(this.countries);

  @override
  List<Object> get props => [countries];
}

class CountryListError extends CountryListState {
  final String message;
  const CountryListError(this.message);

  @override
  List<Object> get props => [message];
}
