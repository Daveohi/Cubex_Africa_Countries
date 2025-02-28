import 'package:africa_countries/core/shared/shimmer_loader.dart';
import 'package:africa_countries/core/utils/app_colors.dart';
import 'package:africa_countries/features/country/presentation/countrylist/widget/country_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/country_list_cubit.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountryListCubit, CountryListState>(
      listener: (context, state) {
        if (state is CountryListError) {
          // Show SnackBar on error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.redDevil,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: BlocBuilder<CountryListCubit, CountryListState>(
        builder: (context, state) {
          if (state is CountryListLoading) return const ShimmerLoader();

          if (state is CountryListError) {
            return _buildErrorUI(context);
          }

          if (state is CountryListLoaded) {
            return CountryListItem(
              countries: state.countries,
              onRefresh: () =>
                  context.read<CountryListCubit>().fetchCountries(),
            );
          }
          return const Center(child: Text('Pull to load countries'));
        },
      ),
    );
  }

  Widget _buildErrorUI(
    BuildContext context,
    // String errorMessage
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<CountryListCubit>().fetchCountries(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Retry',
                style: GoogleFonts.openSans(
                  color: AppColors.black,
                )),
          ),
        ],
      ),
    );
  }
}
