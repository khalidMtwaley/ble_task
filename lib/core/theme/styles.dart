import 'package:ble_task/core/theme/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static TextStyle mainTextStyle() => const TextStyle(
        // fontFamily: 
      );
//////////////////

  static textStyle300({
    required double fontSize,
    required Color color,
  }) {
    return mainTextStyle().copyWith(
      // fontFamily:
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w300,
      color: color,
    );
  }

  //////////////////
  static textStyle400({
    required double fontSize,
    required Color color,
  }) {
    return mainTextStyle().copyWith(
      fontFamily: 'Rubik-Regular',
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  /////////////////
  static textStyle500({
    required double fontSize,
    required Color color,
  }) {
    return mainTextStyle().copyWith(
      // fontFamily: 
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }
  ////////////////

  static textStyle600({
    required double fontSize,
    required Color color,
  }) {
    return mainTextStyle().copyWith(
      // fontFamily: 
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  //////////
  static TextStyle ButtomStyle({
    Color? color,
  }) {
    return mainTextStyle().copyWith(
      // fontFamily: 
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: color ?? ColorsManager.white,
    );
  }
}
