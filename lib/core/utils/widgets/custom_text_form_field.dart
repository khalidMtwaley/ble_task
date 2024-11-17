

// import 'package:best_touch/core/theme/colors_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTextFormField extends StatefulWidget {
//   final String hint;
//   final bool? readonly;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final int? maxLines;
//   final bool isPassword;
//   final int? maxLength;
//   final Widget? helper;
//   final Color? fillColor;
//   final bool isEnable;
//   final Widget? prefix;
//   final Widget? suffix;
//   final Widget? label;
//   final EdgeInsets? contentPadding;
//   final TextStyle? hintStyle;
//   final Future<Null> Function()? onTap;
//   final TextInputType? keyboardType;

//   CustomTextFormField({
//     this.readonly,
//     this.label,
//     super.key,
//     required this.hint,
//     required this.controller,
//     this.validator,
//     this.suffix,
//     this.fillColor,
//     this.isEnable = true,
//     this.maxLines,
//     this.prefix,
//     this.isPassword = false,
//     this.maxLength,
//     this.helper,
//     this.contentPadding,
//     this.hintStyle,
//     this.onTap,
//     this.keyboardType,
//   });

//   @override
//   _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
// }

// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   ValueNotifier<bool>? isObscureNotifier;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize as null and assign value only if isPassword is true
//     if (widget.isPassword) {
//       isObscureNotifier = ValueNotifier<bool>(true);
//     }
//   }

//   @override
//   void dispose() {
//     // Dispose notifier only if it was initialized
//     isObscureNotifier?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.isPassword
//         ? ValueListenableBuilder<bool>(
//             valueListenable: isObscureNotifier!,
//             builder: (context, isObscure, child) {
//               return buildTextFormField(isObscure);
//             },
//           )
//         : buildTextFormField(false);
//   }

//   TextFormField buildTextFormField(bool isObscure) {
//     return TextFormField(
//       keyboardType: widget.keyboardType ?? TextInputType.text,
//       onTap: widget.onTap,
//       readOnly: widget.readonly ?? false,
//       controller: widget.controller,
//       validator: widget.validator,
//       obscureText: widget.isPassword ? isObscure : false,
//       decoration: InputDecoration(
//         enabled: widget.isEnable,
//         suffixIcon: widget.isPassword
//             ? IconButton(
//                 onPressed: () {
//                   isObscureNotifier!.value = !isObscureNotifier!.value;
//                 },
//                 icon: isObscure
//                     ? const Icon(Icons.visibility_off_outlined)
//                     : const Icon(Icons.visibility_outlined),
//               )
//             : widget.suffix,
//         prefixIcon: widget.prefix,
//         contentPadding: widget.contentPadding ??
//             EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4.r),
//           borderSide: BorderSide(
//             width: 1.w,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4.r),
//           borderSide: BorderSide(
//             color: ColorsManager.bordergrey,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4.r),
//           borderSide: BorderSide(
//             color: ColorsManager.primary,
//             width: 1.w,
//           ),
//         ),
//         hintStyle: widget.hintStyle,
//         hintText: widget.hint,
//       ),
//     );
//   }
// }
