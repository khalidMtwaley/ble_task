import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_manager.dart';
import 'styles.dart';

class AppTheme {
  //Light theme

  static final lightThemeMode = ThemeData(
    // fontFamily:

    scaffoldBackgroundColor: ColorsManager.white,
    appBarTheme: AppBarTheme(
        titleTextStyle:
            Styles.textStyle500(fontSize: 20, color: ColorsManager.white),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: ColorsManager.primary,
        elevation: 5),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //     backgroundColor: AppPallete.gradient3),
    // chipTheme: const ChipThemeData(
    //   color: WidgetStatePropertyAll(
    //     AppPallete.lightBackgroundColor,
    //   ),
    //   side: BorderSide.none,
    // ),
    //* Tab Bar Theme
    // tabBarTheme: TabBarTheme(
    //     dividerColor: Colors.transparent,
    //     indicatorSize: TabBarIndicatorSize.tab,
    //     indicator: BoxDecoration(
    //       color: ColorsManager.primary,
    //       borderRadius: BorderRadius.circular(6.r),
    //     ),
    //     labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
    //     labelColor: Colors.white,
    //     unselectedLabelColor: ColorsManager.grey,
    //     labelStyle: Styles.textStyle400(fontSize: 16, color: Colors.white),
    //     unselectedLabelStyle:
    //         Styles.textStyle400(fontSize: 16, color: ColorsManager.grey)),
  );
}
