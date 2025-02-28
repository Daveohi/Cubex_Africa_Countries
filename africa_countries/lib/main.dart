import 'package:africa_countries/core/utils/app_colors.dart';
import 'package:africa_countries/data/repositories/country_repository.dart';
import 'package:africa_countries/features/country/presentation/countrylist/cubit/country_list_cubit.dart';
import 'package:africa_countries/features/country/presentation/countrylist/widget/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CountryRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CountryListCubit(
              context.read<CountryRepository>(),
            )..fetchCountries(),
          ),
        ],
        child: MaterialApp(
          title: 'African Countries',
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
            backgroundColor: AppColors.offWhite,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              title: Text(
                'African Countries',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [],
            ),
            body: CountryList(),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
