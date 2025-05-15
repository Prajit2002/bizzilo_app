import 'package:flutter/material.dart';

class ResponsiveUtils {
  /// Returns `true` if screen width < 600 (typically phones)
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  /// Returns `true` if screen width is between 600 and 1200 (typically tablets)
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  /// Returns `true` if screen width >= 1200 (typically desktop/web)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  /// Determines how many columns to show in a grid based on screen size
  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;  
    if (isTablet(context)) return 3;
    return 4; // Desktop
  }

  /// Horizontal padding for sections
  static double getSectionPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 32.0; // Desktop
  }

  /// Banner height depending on screen size
  static double getBannerHeight(BuildContext context) {
    if (isMobile(context)) return 200.0;
    if (isTablet(context)) return 300.0;
    return 400.0; // Desktop
  }

static double getGridSpacing(BuildContext context) {
  if (isMobile(context)) return 12.0;
  if (isTablet(context)) return 16.0;
  return 20.0; // Desktop
}
  static double getSummerSaleCardHeight(BuildContext context) {
  if (isMobile(context)) return 180;
  if (isTablet(context)) return 220;
  return 260; // Desktop
}


  /// Optional: Product card height for fixed layout
  static double getProductCardHeight(BuildContext context) {
    if (isMobile(context)) return 220.0;
    if (isTablet(context)) return 240.0;
    return 260.0; // Desktop
  }

}
