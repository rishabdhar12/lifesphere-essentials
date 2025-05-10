import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lifesphere_essentials/core/common/widgets/elevated_button.dart';
import 'package:lifesphere_essentials/core/common/widgets/text.dart';
import 'package:lifesphere_essentials/core/constants/asset_string.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';
import 'package:lifesphere_essentials/core/constants/route_names.dart';
import 'package:lifesphere_essentials/core/constants/strings.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(AssetStrings.logoGreen),
            const SizedBox(height: 6),
            textWidget(
              text: AppStrings.appName,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: ColorCodes.lightGreen,
              letterSpacing: 1.0,
            ),
            const SizedBox(height: 6),
            textWidget(text: AppStrings.tagLine, color: ColorCodes.lightGreen, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            elevatedButton(
              width: 207,
              height: 45,
              onPressed: () {
                if (context.mounted) {
                  context.push(RouteNames.loginScreen);
                }
              },
              textWidget: textWidget(
                text: AppStrings.login,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorCodes.appBackground,
              ),
            ),
            const SizedBox(height: 10),
            elevatedButton(
              width: 207,
              height: 45,
              onPressed: () => {context.push(RouteNames.signupScreen)},
              buttonColor: ColorCodes.lightGreen,
              textWidget: textWidget(
                text: AppStrings.signUp,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorCodes.appBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
