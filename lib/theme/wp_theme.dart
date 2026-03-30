import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:texans_web/theme/wp_colors.dart';

class WpTheme {
  WpTheme._();

  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: WpColors.scaffold,
      colorScheme: ColorScheme.fromSeed(
        seedColor: WpColors.black,
        primary: WpColors.black,
        error: WpColors.danger,
        surface: WpColors.card,
      ),
      useMaterial3: true,
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: WpColors.textPrimary,
        displayColor: WpColors.textPrimary,
      ),
      dividerColor: WpColors.border,
      dialogTheme: DialogThemeData(
        backgroundColor: WpColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
