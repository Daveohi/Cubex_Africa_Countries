import 'package:africa_countries/data/models/countrymodels.dart';
import 'package:africa_countries/data/repositories/country_repository.dart';
import 'package:africa_countries/features/country/presentation/country_details/country_details_view.dart';
import 'package:africa_countries/features/country/presentation/country_details/cubit/country_details_cubit.dart';
import 'package:africa_countries/features/country/presentation/countrylist/country_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListItem extends StatelessWidget {
  final List<Country> countries;
  final Future<void> Function() onRefresh;

  const CountryListItem(
      {super.key, required this.countries, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => CountryListScreen(
          country: countries[index],
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => BlocProvider(
              create: (context) => CountryDetailsCubit(
                context.read<CountryRepository>(),
              )..loadCountryDetails(countries[index].officialName),
              child: CountryDetailsView(country: countries[index]),
            ),
          ),
        ),
      ),
    );
  }
}
