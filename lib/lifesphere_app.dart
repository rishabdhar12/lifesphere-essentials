import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifesphere_essentials/bloc_providers.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';
import 'package:lifesphere_essentials/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp.router(
        title: 'Lifesphere Essentials',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorCodes.appBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: ColorCodes.buttonColor),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routerConfig: router,
      ),
    );
  }
}
