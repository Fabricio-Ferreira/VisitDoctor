import 'package:flutter/material.dart';

import 'styles_utils.dart';

class AppColorScheme {
  static const Color primary = Color(0xFF013156);
  static const Color background = Color(0xFFFFFFFF);
  static const Color bodyText = Color(0xFF334155);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color bottomNavigatorColor = Color(0xFF025481);
  static const Color appBarColor = Color(0xFF0475A1);
  static const Color inactiveText = Color(0xFF94A3B8);
  static const Color error = Color(0xFFE11D48);
  static const Color buttonSuccess = Color(0xFF059CC0);
  static const Color buttonDisabled = Color(0xFFE7E5E4);
  static const Color secondary = Color(0xFFFDEAD7);
  static const Color backgroundSnackBar = Color(0xFF1E293B);
  static const Color optionColorButtonNo = Color(0xFF78716C);
  static const Color shadow = Color(0x4B000000);
  static const Color border = Color(0xFFE0E0E0);

  static final MaterialColor primarySwatch = StyleUtils.createMaterialColor(primary);
  static final MaterialColor accentColor = StyleUtils.createMaterialColor(primary);
}
