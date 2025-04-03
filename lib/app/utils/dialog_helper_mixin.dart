import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_color_scheme.dart';
import 'constants.dart';

mixin DialogHelperMixin {
  void customSnackBar(String text) => Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          text,
          style: TextStyle(
            color: AppColorScheme.background,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: Constants.fontFamilyPoppins,
          ),
        ),
        backgroundColor: AppColorScheme.backgroundSnackBar,
        colorText: AppColorScheme.background,
        snackStyle: SnackStyle.FLOATING,
      );
}
