import 'package:ble_task/core/theme/theme.dart';
import 'package:ble_task/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        builder: (context) {
          return  MaterialApp(
            theme: AppTheme.lightThemeMode,
            debugShowCheckedModeBanner: false,
            home: ScanScreen(),
          );
        }
      ),
    );
  }
}
