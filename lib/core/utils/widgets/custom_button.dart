import 'package:ble_task/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttoncolor,
    this.txtColor,
    this.borderColor,
    this.buttonHight,
    this.style,
    this.fontSizeBtnTxt,
  });

  final void Function()? onPressed;
  final String label;
  final Color? buttoncolor;
  final Color? txtColor;
  final Color? borderColor;
  final double? buttonHight;
  final TextStyle? style;
  final double? fontSizeBtnTxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
              side: borderColor != null
                  ? BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: .5,
                      style: BorderStyle.solid)
                  : const BorderSide(style: BorderStyle.none)),
          backgroundColor: buttoncolor,
          fixedSize: Size.fromHeight(buttonHight ?? 48.h),
        ),
        child: Center(
          child: Text(
            label,
            style: style ??
                Styles.ButtomStyle(
                  color: txtColor ?? Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
