// // invitation_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:texans_app/web_panel/ScreenUtils/screen_utils.dart';
// import 'package:texans_app/web_panel/controllers/invitation_controller.dart';
// import 'package:texans_app/web_panel/pages/register_page.dart';
// import 'package:texans_app/web_panel/widgets/otp_row.dart';
// import 'package:texans_app/web_panel/widgets/wp_button.dart';

// class InvitationPage extends StatefulWidget {
//   final String email;
//   final String? name;

//   const InvitationPage({super.key, required this.email, this.name});

//   @override
//   State<InvitationPage> createState() => _InvitationPageState();
// }

// class _InvitationPageState extends State<InvitationPage> {
//   late final List<TextEditingController> _otpControllers;
//   late final InvitationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _otpControllers = List.generate(6, (_) => TextEditingController());
//     _controller = InvitationController(email: widget.email, name: widget.name);

//     for (int i = 0; i < _otpControllers.length; i++) {
//       _otpControllers[i].addListener(() {
//         _controller.otpDigits[i] = _otpControllers[i].text;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     for (final t in _otpControllers) {
//       t.dispose();
//     }
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Use the shared WebSpec — no more private _ResponsiveSpec
//           final spec = WebSpec.fromConstraints(constraints);
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: spec.outerPadding),
//               child: _buildCard(spec),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCard(WebSpec spec) {
//     return Obx(
//       () => Container(
//         width: spec.cardWidth,
//         height: spec.cardHeight,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(spec.cardRadius),
//           border: Border.all(color: const Color(0xFFE9EBEF)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.10),
//               blurRadius: 24,
//               spreadRadius: 1,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(spec.cardPadding),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: _buildContent(spec),
//                 ),
//               ),
//               SizedBox(height: spec.buttonTopGap),
//               WpButton.primary(
//                 label: 'Accept & setup account',
//                 height: spec.buttonHeight,
//                 fontSize: spec.buttonFontSize,
//                 borderRadius: spec.buttonRadius,
//                 enabled: !_controller.isLocked,
//                 onPressed: () async {
//                   if (_controller.otp.length != 6) {
//                     Get.snackbar(
//                       'Error',
//                       'Please enter complete 6-digit OTP',
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: Colors.red[100],
//                       colorText: Colors.red[900],
//                     );
//                     return;
//                   }
//                   Navigator.of(context).push(
//                     MaterialPageRoute<void>(
//                       builder: (_) => RegisterPage(
//                         email: widget.email,
//                         otp: _controller.otp,
//                         name: widget.name,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: spec.sectionGap), // was hardcoded SizedBox(30)
//               WpButton.secondary(
//                 label: 'Decline',
//                 height: spec.buttonHeight,
//                 fontSize: spec.buttonFontSize,
//                 borderRadius: spec.buttonRadius,
//                 isLoading: _controller.isDeclining.value,
//                 enabled: !_controller.isLocked,
//                 onPressed: () async {
//                   final confirm = await showDialog<bool>(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Decline Invitation'),
//                       content: const Text(
//                         'Are you sure you want to decline this invitation?',
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, false),
//                           child: const Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, true),
//                           child: const Text('Decline'),
//                         ),
//                       ],
//                     ),
//                   );
//                   if (confirm == true) {
//                     final success = await _controller.decline();
//                     if (success) {
//                       Navigator.of(context).pop();
//                     }
//                   }
//                 },
//               ),
//               SizedBox(height: spec.sectionGap * 0.55),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(WebSpec spec) {
//     return Obx(
//       () => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: spec.iconSize,
//             height: spec.iconSize,
//             decoration: const BoxDecoration(
//               color: Color(0xFFF2F4F7),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.person_outline,
//               size: spec.iconInnerSize,
//               color: const Color(0xFF6B7280),
//             ),
//           ),
//           SizedBox(height: spec.sectionGap),
//           Text(
//             'Set Up Your Account',
//             style: TextStyle(
//               fontSize: spec.titleSize,
//               fontWeight: FontWeight.w700,
//               color: const Color(0xFF111827),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: spec.sectionGap * 0.4),
//           Text(
//             'Complete your coach registration',
//             style: TextStyle(
//               fontSize: spec.subtitleSize,
//               color: const Color(0xFF6B7280),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: spec.sectionGap),
//           if (_controller.name.value.isNotEmpty)
//             Column(
//               children: [
//                 Text(
//                   'Welcome, ${_controller.name.value}!',
//                   style: TextStyle(
//                     fontSize: spec.bodySize,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xFF111827),
//                   ),
//                 ),
//                 SizedBox(height: spec.sectionGap * 0.5),
//               ],
//             ),
//           Text(
//             '—',
//             style: TextStyle(
//               fontSize: spec.bodySize,
//               color: const Color(0xFF9CA3AF),
//             ),
//           ),
//           SizedBox(height: spec.sectionGap * 0.5),
//           Text(
//             'Read Only',
//             style: TextStyle(
//               fontSize: spec.subtitleSize,
//               color: const Color(0xFF6B7280),
//             ),
//           ),
//           SizedBox(height: spec.sectionGap),
//           OtpRow(
//             controllers: _otpControllers,
//             enabled: !_controller.isLocked,
//             boxWidth: spec.otpBoxWidth,
//             boxHeight: spec.otpBoxHeight,
//             fontSize: spec.otpFontSize,
//             horizontalSpacing: spec.otpSpacing,
//             borderRadius: spec.otpRadius,
//             onChanged: (idx, v) {
//               if (v.trim().isNotEmpty && idx < _otpControllers.length - 1) {
//                 FocusScope.of(context).nextFocus();
//               }
//             },
//           ),
//           SizedBox(height: spec.sectionGap * 0.6),
//           GestureDetector(
//             onTap: _controller.resendSeconds.value == 0
//                 ? () => _controller.resendOtp()
//                 : null,
//             child: Text(
//               _controller.resendSeconds.value > 0
//                   ? 'Resend code in ${_formatTime(_controller.resendSeconds.value)}'
//                   : 'Resend code',
//               style: TextStyle(
//                 fontSize: spec.bodySize,
//                 color: _controller.resendSeconds.value == 0
//                     ? const Color(0xFF2563EB)
//                     : const Color(0xFF6B7280),
//                 fontWeight: _controller.resendSeconds.value == 0
//                     ? FontWeight.w600
//                     : FontWeight.normal,
//               ),
//             ),
//           ),
//           SizedBox(height: spec.sectionGap),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Permission Details',
//               style: TextStyle(
//                 fontSize: spec.sectionTitleSize,
//                 fontWeight: FontWeight.w700,
//                 color: const Color(0xFF111827),
//               ),
//             ),
//           ),
//           SizedBox(height: spec.sectionGap * 0.5),
//           _bullet('View Player Information', spec),
//           _bullet('View schedules and tournaments', spec),
//           _bullet('View team roster', spec),
//           _bullet('Cannot edit or manage data', spec),
//         ],
//       ),
//     );
//   }

//   String _formatTime(int seconds) {
//     final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
//     final secs = (seconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$secs';
//   }

//   Widget _bullet(String text, WebSpec spec) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: spec.subtitleSize * 0.45),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: spec.bulletDotSize,
//             height: spec.bulletDotSize,
//             margin: EdgeInsets.only(top: spec.bulletDotSize * 0.55),
//             decoration: const BoxDecoration(
//               color: Color(0xFF6B7280),
//               shape: BoxShape.circle,
//             ),
//           ),
//           SizedBox(width: spec.bulletDotSize + 2),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: spec.bulletSize,
//                 color: const Color(0xFF6B7280),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
