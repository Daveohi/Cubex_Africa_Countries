part of 'country_details_cubit.dart';

abstract class CountryDetailsState extends Equatable {
  const CountryDetailsState();

  @override
  List<Object> get props => [];
}

class CountryDetailsInitial extends CountryDetailsState {}

class CountryDetailsLoading extends CountryDetailsState {}

class CountryDetailsLoaded extends CountryDetailsState {
  final Country country;
  const CountryDetailsLoaded(this.country);

  @override
  List<Object> get props => [country];
}

class CountryDetailsError extends CountryDetailsState {
  final String message;
  const CountryDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
