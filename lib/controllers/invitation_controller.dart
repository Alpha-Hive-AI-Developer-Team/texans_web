import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:texans_web/api/wp_api.dart';

class InvitationController extends GetxController {
  final RxString email = ''.obs;
  final RxString otp = ''.obs;
  final RxString action = 'set'.obs;

  final RxBool isAcceptLoading = false.obs;
  final RxBool isDeclineLoading = false.obs; // ← separate loader

  InvitationController({
    required String email,
    required String otp,
    String action = 'set',
  }) {
    this.email.value = email.trim();
    this.otp.value = otp.trim();
    this.action.value = action;
  }

  /// ✅ Accept Invitation (Set Password)
  Future<bool> acceptInvitation({
    required String password,
    required String confirmPassword,
  }) async {
    isAcceptLoading.value = true;
    try {
      final response = await WpApi.acceptInvitation(
        email: email.value,
        otp: otp.value,
        action: action.value,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[900],
        );
        return true;
      } else {
        _showErrorFromResponse(
          response.body,
          fallback: 'Failed to create account',
        );
        return false;
      }
    } catch (_) {
      _showNetworkError();
      return false;
    } finally {
      isAcceptLoading.value = false;
    }
  }

  /// ❌ Decline Invitation
  Future<bool> declineInvitation() async {
    isDeclineLoading.value = true;
    try {
      final response = await WpApi.declineInvitation(email: email.value);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar(
          'Declined',
          'You have declined the invitation.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange[100],
          colorText: Colors.orange[900],
        );
        return true;
      } else {
        _showErrorFromResponse(
          response.body,
          fallback: 'Failed to decline invitation',
        );
        return false;
      }
    } catch (_) {
      _showNetworkError();
      return false;
    } finally {
      isDeclineLoading.value = false;
    }
  }

  // ── Private helpers ──────────────────────────────────────────────

  void _showErrorFromResponse(String body, {required String fallback}) {
    String message = fallback;
    try {
      final parsed = jsonDecode(body);
      message = parsed['message'] ?? parsed['error'] ?? fallback;
    } catch (_) {
      message = body.isNotEmpty ? body : fallback;
    }
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
    );
  }

  void _showNetworkError() {
    Get.snackbar(
      'Error',
      'Network error. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[900],
    );
  }
}
