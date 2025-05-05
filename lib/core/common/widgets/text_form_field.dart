import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';

Widget textFormField({
  Color fillColor = ColorCodes.lightGreen,
  String hintText = "",
  String? initialText,
  TextEditingController? controller,
  TextInputType textInputType = TextInputType.text,
  bool obscureText = false,
  IconData? icon,
  void Function()? onPressed,
  String? Function(String?)? validator,
  Widget? suffixIcon,
  bool enabled = true,
  double borderRadius = 6.0,
  double? height,
  double contentPaddingHorizontal = 14.0,
  double contentPaddingVertical = 10.0,
  void Function(String)? onChanged,
  String? prefixText,
  int maxLines = 1,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: fillColor,
    ),
    child: TextFormField(
      initialValue: initialText,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixText: prefixText,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: contentPaddingHorizontal,
          vertical: contentPaddingVertical,
        ),
        hintText: hintText,
      ),
    ),
  );
}
