// // otp_row.dart
// import 'package:flutter/material.dart';
// import 'package:texans_web/theme/wp_colors.dart';

// class OtpRow extends StatelessWidget {
//   const OtpRow({
//     super.key,
//     required this.controllers,
//     required this.enabled,
//     required this.onChanged,
//     this.boxWidth,
//     this.boxHeight,
//     this.fontSize,
//     this.horizontalSpacing,
//     this.borderRadius,
//   });

//   final List<TextEditingController> controllers;
//   final bool enabled;
//   final void Function(int index, String value) onChanged;

//   final double? boxWidth;
//   final double? boxHeight;
//   final double? fontSize;
//   final double? horizontalSpacing;
//   final double? borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     final width = boxWidth ?? 48.0;
//     final height = boxHeight ?? 48.0;
//     final textSize = fontSize ?? 16.0;
//     final spacing = horizontalSpacing ?? 4.0;
//     final radius = borderRadius ?? 8.0;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(controllers.length, (i) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: spacing),
//           child: SizedBox(
//             width: width,
//             height: height,
//             child: TextField(
//               controller: controllers[i],
//               enabled: enabled,
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.number,
//               maxLength: 1,
//               style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w600),
//               decoration: InputDecoration(
//                 counterText: '',
//                 filled: true,
//                 fillColor: Colors.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(radius),
//                   borderSide: const BorderSide(color: WpColors.border),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(radius),
//                   borderSide: const BorderSide(
//                     color: WpColors.black,
//                     width: 1.4,
//                   ),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(radius),
//                   borderSide: BorderSide(
//                     color: WpColors.border.withOpacity(0.5),
//                   ),
//                 ),
//               ),
//               onChanged: (v) => onChanged(i, v),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
