import 'package:flutter/cupertino.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';

Widget backButton(
  BuildContext context, {
  void Function()? onPressed,
  Color color = ColorCodes.buttonColor,
  IconData icon = CupertinoIcons.back,
  Color iconColor = ColorCodes.appBackground,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(child: Icon(icon, color: iconColor, size: 30.0)),
    ),
  );
}
