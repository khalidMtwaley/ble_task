// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math' as math;

// class LocalizedElevatedButtonIcon extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String icon;
//   final Widget label;
//   final ButtonStyle? style;
//   final FocusNode? focusNode;
//   final bool autofocus;
//   final Clip clipBehavior;

//   const LocalizedElevatedButtonIcon({
//     Key? key,
//     required this.onPressed,
//     required this.icon,
//     required this.label,
//     this.style,
//     this.focusNode,
//     this.autofocus = false,
//     this.clipBehavior = Clip.none,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isRtl = Directionality.of(context) == TextDirection.rtl;
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
//       width: double.infinity,
//       height: 46.h,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: style,
//         focusNode: focusNode,
//         autofocus: autofocus,
//         clipBehavior: clipBehavior,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             label,
//             SizedBox(width: 8.w),
//             Transform(
//               transform:
//                   isRtl ? Matrix4.rotationY(0) : Matrix4.rotationY(3.14159),
//               alignment: Alignment.center,
//               child: SvgPicture.asset(
//                 icon,
//                 width: 24.w, // Adjust the size of the icon here
//                 height: 24.h,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
