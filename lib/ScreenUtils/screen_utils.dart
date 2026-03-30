import 'package:flutter/material.dart';

enum WebBreakpoint { mobile, tablet, desktop }

class ScreenUtils {
  ScreenUtils._();

  static const double kMobileBreakpoint = 600;
  static const double kDesktopBreakpoint = 1024;

  static WebBreakpoint breakpoint(double width) {
    if (width >= kDesktopBreakpoint) return WebBreakpoint.desktop;
    if (width >= kMobileBreakpoint) return WebBreakpoint.tablet;
    return WebBreakpoint.mobile;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < kMobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= kMobileBreakpoint && w < kDesktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= kDesktopBreakpoint;
}

class WebSpec {
  const WebSpec({
    // card
    required this.cardWidth,
    required this.cardHeight,
    required this.outerPadding,
    required this.cardPadding,
    required this.cardRadius,
    // icon
    required this.iconSize,
    required this.iconInnerSize,
    // typography
    required this.titleSize,
    required this.subtitleSize,
    required this.bodySize,
    required this.sectionTitleSize,
    required this.bulletSize,
    // spacing
    required this.sectionGap,
    required this.bulletDotSize,
    // otp
    required this.otpBoxWidth,
    required this.otpBoxHeight,
    required this.otpFontSize,
    required this.otpSpacing,
    required this.otpRadius,
    // text field
    required this.textFieldHeight,
    required this.textFieldFontSize,
    required this.textFieldRadius,
    // button
    required this.buttonHeight,
    required this.buttonFontSize,
    required this.buttonRadius,
    required this.buttonTopGap,
  });

  // card
  final double cardWidth;
  final double cardHeight;
  final double outerPadding;
  final double cardPadding;
  final double cardRadius;
  // icon
  final double iconSize;
  final double iconInnerSize;
  // typography
  final double titleSize;
  final double subtitleSize;
  final double bodySize;
  final double sectionTitleSize;
  final double bulletSize;
  // spacing
  final double sectionGap;
  final double bulletDotSize;
  // otp
  final double otpBoxWidth;
  final double otpBoxHeight;
  final double otpFontSize;
  final double otpSpacing;
  final double otpRadius;
  // text field
  final double textFieldHeight;
  final double textFieldFontSize;
  final double textFieldRadius;
  // button
  final double buttonHeight;
  final double buttonFontSize;
  final double buttonRadius;
  final double buttonTopGap;

  /// Resolve spec from layout constraints (use inside LayoutBuilder).
  factory WebSpec.fromConstraints(BoxConstraints constraints) {
    return WebSpec.fromSize(constraints.maxWidth, constraints.maxHeight);
  }

  /// Resolve spec from explicit width / height values.
  factory WebSpec.fromSize(double width, double height) {
    switch (ScreenUtils.breakpoint(width)) {
      case WebBreakpoint.desktop:
        return WebSpec._desktop();
      case WebBreakpoint.tablet:
        return WebSpec._tablet(width, height);
      case WebBreakpoint.mobile:
        return WebSpec._mobile(width, height);
    }
  }

  /// Convenience: resolve spec from the nearest MediaQuery.
  factory WebSpec.of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WebSpec.fromSize(size.width, size.height);
  }

  factory WebSpec._desktop() {
    return const WebSpec(
      // card
      cardWidth: 428,
      cardHeight: 480,
      outerPadding: 24,
      cardPadding: 14,
      cardRadius: 8,
      // icon — inner must be < outer
      iconSize: 50,
      iconInnerSize: 24,
      // typography
      titleSize: 16,
      subtitleSize: 12,
      bodySize: 10,
      sectionTitleSize: 11,
      bulletSize: 10,
      // spacing
      sectionGap: 8,
      bulletDotSize: 4,
      // otp
      otpBoxWidth: 48,
      otpBoxHeight: 48,
      otpFontSize: 15,
      otpSpacing: 4,
      otpRadius: 4,
      // text field
      textFieldHeight: 36,
      textFieldFontSize: 12,
      textFieldRadius: 7,
      // button
      buttonHeight: 34,
      buttonFontSize: 13,
      buttonRadius: 5,
      buttonTopGap: 14,
    );
  }

  factory WebSpec._tablet(double width, double height) {
    return WebSpec(
      // card
      cardWidth: width.clamp(320, 460),
      cardHeight: height.clamp(500, 760),
      outerPadding: 20,
      cardPadding: 22,
      cardRadius: 12,
      // icon
      iconSize: 56,
      iconInnerSize: 28,
      // typography
      titleSize: 22,
      subtitleSize: 14,
      bodySize: 13,
      sectionTitleSize: 14,
      bulletSize: 13,
      // spacing
      sectionGap: 14,
      bulletDotSize: 6,
      // otp
      otpBoxWidth: 52,
      otpBoxHeight: 52,
      otpFontSize: 18,
      otpSpacing: 4,
      otpRadius: 8,
      // text field
      textFieldHeight: 50,
      textFieldFontSize: 14,
      textFieldRadius: 10,
      // button
      buttonHeight: 46,
      buttonFontSize: 14,
      buttonRadius: 10,
      buttonTopGap: 10,
    );
  }

  factory WebSpec._mobile(double width, double height) {
    return WebSpec(
      // card — on mobile the card fills available width with a small margin
      cardWidth: width.clamp(300, 420),
      cardHeight: height.clamp(380, 600),
      outerPadding: 10,
      cardPadding: 16,
      cardRadius: 10,
      // icon
      iconSize: 50,
      iconInnerSize: 24,
      // typography
      titleSize: 18,
      subtitleSize: 13,
      bodySize: 12,
      sectionTitleSize: 13,
      bulletSize: 12,
      // spacing
      sectionGap: 10,
      bulletDotSize: 5,
      // otp
      otpBoxWidth: 42,
      otpBoxHeight: 48,
      otpFontSize: 16,
      otpSpacing: 3,
      otpRadius: 7,
      // text field
      textFieldHeight: 44,
      textFieldFontSize: 13,
      textFieldRadius: 8,
      // button
      buttonHeight: 42,
      buttonFontSize: 13,
      buttonRadius: 9,
      buttonTopGap: 8,
    );
  }
}
