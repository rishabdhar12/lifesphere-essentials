import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lifesphere_essentials/core/common/widgets/text.dart';
import 'package:lifesphere_essentials/core/constants/asset_string.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';
import 'package:lifesphere_essentials/core/constants/route_names.dart';
import 'package:lifesphere_essentials/core/constants/strings.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/service/hive_service/hive_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _userHiveService = getIt<HiveService>();

  @override
  void initState() {
    super.initState();
    navigateToLoginOrSignupScreen();
  }

  void navigateToLoginOrSignupScreen() {
    _userHiveService
        .getUser()
        .then((user) {
          context.pushReplacement(RouteNames.categoriesScreen);
        })
        .catchError((error) {
          log("Error getting user: $error");
          context.pushReplacement(RouteNames.loginOrSignup);
        });

    // Future.delayed(const Duration(seconds: 2), () async {
    //   if (context.mounted) {
    //     context.pushReplacement(RouteNames.loginOrSignup);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.appBackground,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AssetStrings.logo,
              colorFilter: const ColorFilter.mode(
                ColorCodes.splashBackground,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 10),
            textWidget(
              text: AppStrings.appName,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
