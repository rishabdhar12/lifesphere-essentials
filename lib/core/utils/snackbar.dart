import 'package:flutter/material.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';

void showSnackBar(
  BuildContext context, {
  String? message,
  bool isError = false,
}) {
  final snackBar = SnackBar(
    content: Text(message!),
    duration: const Duration(seconds: 2),
    backgroundColor: isError ? ColorCodes.red : ColorCodes.darkGreen,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
