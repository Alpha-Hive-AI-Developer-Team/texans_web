import 'dart:convert';

import 'package:http/http.dart' as http;

class WpApi {
  WpApi._();

  static bool enableLogging = true;

  static Uri _uri(String path, [Map<String, String>? query]) {
    final base = "https://texans-baseball-backend.up.railway.app";
    return Uri.parse('$base$path').replace(queryParameters: query);
  }

  static Future<http.Response> _postJson(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final mergedHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    if (enableLogging) {
      // ignore: avoid_print
      print('[HTTP] POST $uri');
      // ignore: avoid_print
      print('[HTTP] headers=$mergedHeaders');
      // ignore: avoid_print
      print('[HTTP] body=${body ?? ''}');
    }

    final res = await http.post(uri, headers: mergedHeaders, body: body);

    if (enableLogging) {
      // ignore: avoid_print
      print('[HTTP] status=${res.statusCode}');
      // ignore: avoid_print
      print('[HTTP] response=${res.body}');
    }
    return res;
  }

  static Future<http.Response> _get(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final mergedHeaders = <String, String>{
      'Accept': 'application/json',
      ...?headers,
    };

    if (enableLogging) {
      // ignore: avoid_print
      print('[HTTP] GET $uri');
      // ignore: avoid_print
      print('[HTTP] headers=$mergedHeaders');
    }

    final res = await http.get(uri, headers: mergedHeaders);

    if (enableLogging) {
      // ignore: avoid_print
      print('[HTTP] status=${res.statusCode}');
      // ignore: avoid_print
      print('[HTTP] response=${res.body}');
    }
    return res;
  }

  /// Accept coach invitation with password in body
  static Future<http.Response> coachSetPassword({
    required String email,
    required String otp,
    required String action,
    required String password,
    required String confirmPassword,
  }) {
    final query = <String, String>{
      'email': email,
      'otp': otp,
      'action': action,
    };

    final body = {'password': password, 'confirm_password': confirmPassword};

    return _postJson(
      _uri('/api/v1/coach/auth/reset-password', query),
      body: jsonEncode(body),
    );
  }

  /// Accept player invitation with password in body
  static Future<http.Response> playerSetPassword({
    required String email,
    required String otp,
    required String action,
    required String password,
    required String confirmPassword,
  }) {
    final query = <String, String>{
      'email': email,
      'otp': otp,
      'action': action,
    };

    final body = {'password': password, 'confirm_password': confirmPassword};

    return _postJson(
      _uri('/api/v1/player/auth/reset-password', query),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> parentInvitationAccept({
    required String invitationToken,
  }) {
    final query = <String, String>{'invitation_token': invitationToken};
    return _get(
      _uri('/api/v1/parent/auth/invitation/accept', query),
    );
  }

  /// Set parent password after invitation
  static Future<http.Response> parentSetPassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
    required String action,
  }) {
    final query = <String, String>{
      'email': email,
      'otp': otp,
      'action': action,
    };

    final body = {'password': password, 'confirm_password': confirmPassword};

    return _postJson(
      _uri('/api/v1/parent/auth/reset-password', query),
      body: jsonEncode(body),
    );
  }

  /// Decline coach invitation
  static Future<http.Response> coachDeclineInvitation({required String email}) {
    return _postJson(
      _uri('/api/v1/coach/auth/forgot-password'),
      body: jsonEncode({'email': email}),
    );
  }

  /// Decline player invitation
  static Future<http.Response> playerDeclineInvitation({
    required String email,
  }) {
    return _postJson(
      _uri('/api/v1/player/auth/forgot-password'),
      body: jsonEncode({'email': email}),
    );
  }

  /// Decline parent invitation
  static Future<http.Response> parentDeclineInvitation({
    required String email,
  }) {
    return _postJson(
      _uri('/api/v1/parent/auth/forgot-password'),
      body: jsonEncode({'email': email}),
    );
  }
}
