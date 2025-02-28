import 'package:africa_countries/core/utils/app_colors.dart';
import 'package:africa_countries/core/utils/num_extension.dart';
import 'package:africa_countries/data/models/countrymodels.dart';
import 'package:africa_countries/features/country/presentation/country_details/cubit/country_details_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryDetailsView extends StatelessWidget {
  final Country country;

  const CountryDetailsView({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountryDetailsCubit, CountryDetailsState>(
      listener: (context, state) {
        if (state is CountryDetailsError) {
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
      child: BlocBuilder<CountryDetailsCubit, CountryDetailsState>(
        builder: (context, state) {
          if (state is CountryDetailsLoading) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: AppColors.blue,
            ));
          }
          if (state is CountryDetailsLoaded) {
            return _buildDetailBody(state.country);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailBody(Country country) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Capital ${country.capital}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Time Zones:   ${country.timezones.join(', ')}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoCard(
                                  icon: Icons.location_on_outlined,
                                  label: 'Region',
                                  value: country.region,
                                  color: AppColors.black,
                                ),

                                // Info Card
                                _infoCard(
                                  icon: Icons.location_pin,
                                  label: 'Area',
                                  value: '${country.area.formatNumber()} km²',
                                  color: AppColors.black,
                                ),

                                _infoCard(
                                  icon: Icons.people_rounded,
                                  label: 'Population',
                                  value: country.population.formatNumber(),
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          // Population/ Language Section
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Languages',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  country.languages.values.join(', '),
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.black.withOpacity(0.6),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: country.flag,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.flag),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoCard(
      {IconData? icon,
      required String label,
      required String value,
      required Color color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.5, color: AppColors.grey),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 12,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
