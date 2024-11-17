// import 'package:best_touch/core/theme/colors_manager.dart';
// import 'package:best_touch/core/theme/styles.dart';
// import 'package:best_touch/core/utils/extensions/widget_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final VoidCallback? onLeadingPressed;
//   final Widget? title;
//   final List<Widget>? actions;
//   final Color? backgroundColor;
//   final bool iscenter;
//   final Widget? leadingg;
//   CustomAppBar({
//     this.iscenter = true,
//     this.onLeadingPressed,
//     this.title,
//     this.actions,
//     this.backgroundColor = Colors.transparent,
//     this.leadingg,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isRtl = Directionality.of(context) == TextDirection.rtl;

//     return AppBar(
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       centerTitle: iscenter,
//       backgroundColor: backgroundColor,
//       leading: leadingg ??
//           Container(
//             margin: EdgeInsets.only(
//                 left: 10.w, top: 12.h, bottom: 4.h, right: 10.w),
//             decoration: BoxDecoration(
//                 border: Border.all(color: ColorsManager.bordercolor)),
//             child: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//                 size: 18.sp,
//               ),
//               onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
//             ),
//           ),
//       title: title,
//       titleTextStyle: Styles.Rubic500(fontSize: 16, color: Colors.black),
//       actions: actions,
//     ).paddingLeft(6);
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }
