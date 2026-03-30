// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:texans_app/web_panel/ScreenUtils/screen_utils.dart';
// import 'package:texans_app/web_panel/api/wp_api.dart';
// import 'package:texans_app/web_panel/widgets/wp_button.dart';

// class RegisterPage extends StatefulWidget {
//   final String email;
//   final String otp;
//   final String? name;

//   const RegisterPage({
//     super.key,
//     required this.email,
//     required this.otp,
//     this.name,
//   });

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   bool _hidePassword = true;
//   bool _hideConfirmPassword = true;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
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
//     return Container(
//       width: spec.cardWidth,
//       height: spec.cardHeight,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(spec.cardRadius),
//         border: Border.all(color: const Color(0xFFE9EBEF)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.10),
//             blurRadius: 24,
//             spreadRadius: 1,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(spec.cardPadding),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: spec.iconSize,
//                   height: spec.iconSize,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFF2F4F7),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.person_outline,
//                     size: spec.iconInnerSize, // always < iconSize now
//                     color: const Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap),
//               Center(
//                 child: Text(
//                   widget.name != null && widget.name!.isNotEmpty
//                       ? 'Welcome, ${widget.name}!'
//                       : 'Set Up Your Account',
//                   style: TextStyle(
//                     fontSize: spec.titleSize,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(0xFF111827),
//                   ),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap * 0.4),
//               Center(
//                 child: Text(
//                   'Complete your coach registration',
//                   style: TextStyle(
//                     fontSize: spec.subtitleSize,
//                     color: const Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap),
//               Center(
//                 child: Text(
//                   widget.email,
//                   style: TextStyle(
//                     fontSize: spec.bodySize,
//                     color: const Color(0xFF9CA3AF),
//                   ),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap * 0.5),
//               Center(
//                 child: Text(
//                   'Create your password',
//                   style: TextStyle(
//                     fontSize: spec.subtitleSize,
//                     color: const Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap * 1.2),
//               Text(
//                 'Password',
//                 style: TextStyle(
//                   fontSize: spec.bodySize,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF374151),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap * 0.45),
//               _passwordField(
//                 controller: _passwordController,
//                 hint: 'Enter your password',
//                 isHidden: _hidePassword,
//                 onToggle: () => setState(() => _hidePassword = !_hidePassword),
//                 spec: spec,
//               ),
//               SizedBox(height: spec.sectionGap),
//               Text(
//                 'Confirm Password',
//                 style: TextStyle(
//                   fontSize: spec.bodySize,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF374151),
//                 ),
//               ),
//               SizedBox(height: spec.sectionGap * 0.45),
//               _passwordField(
//                 controller: _confirmPasswordController,
//                 hint: 'Confirm your password',
//                 isHidden: _hideConfirmPassword,
//                 onToggle: () => setState(
//                   () => _hideConfirmPassword = !_hideConfirmPassword,
//                 ),
//                 spec: spec,
//               ),
//               SizedBox(height: spec.sectionGap * 2.5),
//               WpButton.primary(
//                 label: 'Create Account',
//                 height: spec.buttonHeight,
//                 fontSize: spec.buttonFontSize,
//                 borderRadius: spec.buttonRadius,
//                 isLoading: _isLoading,
//                 onPressed: _handleCreateAccount,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _passwordField({
//     required TextEditingController controller,
//     required String hint,
//     required bool isHidden,
//     required VoidCallback onToggle,
//     required WebSpec spec,
//   }) {
//     return SizedBox(
//       height: spec.textFieldHeight,
//       child: TextField(
//         controller: controller,
//         obscureText: isHidden,
//         style: TextStyle(
//           fontSize: spec.textFieldFontSize,
//           color: const Color(0xFF111827),
//         ),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(
//             fontSize: spec.textFieldFontSize,
//             color: const Color(0xFF9CA3AF),
//           ),
//           suffixIcon: IconButton(
//             onPressed: onToggle,
//             icon: Icon(
//               isHidden
//                   ? Icons.visibility_off_outlined
//                   : Icons.visibility_outlined,
//               size: spec.textFieldFontSize + 4,
//               color: const Color(0xFF9CA3AF),
//             ),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 0,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(spec.textFieldRadius),
//             borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(spec.textFieldRadius),
//             borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _handleCreateAccount() async {
//     final password = _passwordController.text.trim();
//     final confirmPassword = _confirmPasswordController.text.trim();

//     if (password.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please enter a password',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[900],
//       );
//       return;
//     }

//     if (password.length < 6) {
//       Get.snackbar(
//         'Error',
//         'Password must be at least 6 characters long',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[900],
//       );
//       return;
//     }

//     if (confirmPassword.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please confirm your password',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[900],
//       );
//       return;
//     }

//     if (password != confirmPassword) {
//       Get.snackbar(
//         'Error',
//         'Passwords do not match',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[900],
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final response = await WpApi.acceptInvitation(
//         email: widget.email,
//         otp: widget.otp,
//         action: 'set',
//         password: password,
//         confirmPassword: confirmPassword,
//       );

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         Get.snackbar(
//           'Success',
//           'Account created successfully! You can now log in.',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green[100],
//           colorText: Colors.green[900],
//           duration: const Duration(seconds: 3),
//         );
//         Future.delayed(const Duration(seconds: 2), () {
//           Navigator.of(context).popUntil((route) => route.isFirst);
//         });
//       } else {
//         String errorMessage = 'Failed to create account';
//         try {
//           final errorBody = jsonDecode(response.body);
//           errorMessage =
//               errorBody['message'] ?? errorBody['error'] ?? errorMessage;
//         } catch (e) {
//           errorMessage = 'Error ${response.statusCode}: ${response.body}';
//         }
//         Get.snackbar(
//           'Error',
//           errorMessage,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red[100],
//           colorText: Colors.red[900],
//           duration: const Duration(seconds: 4),
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Network Error',
//         'Unable to connect to server. Please check your internet connection.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red[100],
//         colorText: Colors.red[900],
//         duration: const Duration(seconds: 4),
//       );
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
// }
