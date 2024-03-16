import 'package:flutter/material.dart';
import 'package:project_x1_news/utils/app_colors.dart';
import 'package:project_x1_news/utils/dimens.dart';

class DashDecoration {
  static InputBorder kInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFieldRadius),
    borderSide: const BorderSide(
      color: kPrimaryColor,
      width: 1.0,
    ),
  );
  static InputBorder kErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(textFieldRadius),
    borderSide: const BorderSide(
      color: kRedColor,
      width: 1.0,
    ),
  );
  static Decoration kNueShadowDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(300),
    color: kWhiteColor,
    boxShadow: [
      const BoxShadow(
        color: Colors.black12,
        offset: Offset(6, 6),
        spreadRadius: 1,
        blurRadius: 4,
      ),
      BoxShadow(
        color: kSecondaryColor.withOpacity(0.1),
        offset: const Offset(-6, -6),
        spreadRadius: 1,
        blurRadius: 4,
      )
    ],
  );
}
