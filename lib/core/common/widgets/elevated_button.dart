import 'package:flutter/material.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';

Widget elevatedButton({
  Color buttonColor = ColorCodes.buttonColor,
  double width = 0,
  double height = 0,
  Widget? textWidget,
  void Function()? onPressed,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      minimumSize: Size(width, height),
      padding: const EdgeInsets.symmetric(vertical: 10),
    ),
    onPressed: onPressed,
    child: textWidget,
  );
}
