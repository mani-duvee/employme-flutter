import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'TokenStorage.dart';

class GetApiCalls {
  /// Reads BASE_URL from the loaded .env file (.env.development /
  /// .env.production). Throws if it's missing, so a misconfigured
  /// environment fails loudly instead of silently hitting the wrong host.
  static String get baseUrl {
    final url = dotenv.env['BASE_URL'];
    if (url == null || url.isEmpty) {
      throw StateError(
        'BASE_URL is not set. Did you forget to call dotenv.load() '
        'with the right .env file, or is BASE_URL missing from it?',
      );
    }
    return url;
  }

  /// Reads API_CALL_TIME_OUT from .env (seconds). Falls back to 10 if
  /// missing / not a number.
  static int get _timeoutSeconds {
    final raw = dotenv.env['API_CALL_TIME_OUT'];
    return int.tryParse(raw ?? '') ?? 10;
  }

  /// Common GET API Call
  ///
  /// [endpoint]         -> API endpoint, example: "emp/home" or "system/{systemid}"
  /// [pathParams]       -> Optional. Replaces "{key}" placeholders in endpoint.
  /// [queryParams]      -> Optional. Appended to the URL as "?key=value&...".
  /// [successCallback]  -> Called with response when API succeeds (2xx). Optional.
  /// [failedCallback]   -> Called with response when API fails / errors. Optional.
  /// [showSuccessNotif] -> Default true. If true, shows the notification widget
  ///                       with `response['message']` on success. Set false to
  ///                       silence it.
  /// [showFailedNotif]  -> Default true. Same, but for failure/error.
  /// [onLoadingStart]   -> Called right before the request starts. Optional.
  /// [onLoadingEnd]     -> Called after success/failure/error. Optional.
  /// [responseNotifier] -> Optional. If passed, gets updated with the parsed
  ///                       response automatically — lets you use the value
  ///                       directly in a widget (via ValueListenableBuilder)
  ///                       without writing your own async/await/setState.
  ///
  /// NOTE: This function handles async/await internally.
  /// Callers should NOT use `await` on this — just call it and pass callbacks.
  static Future<void> get({
    required String endpoint,
    Map<String, String>? pathParams,
    Map<String, dynamic>? queryParams,
    Function(dynamic response)? successCallback,
    Function(dynamic response)? failedCallback,
    bool showSuccessNotif = true,
    bool showFailedNotif = true,
    void Function()? onLoadingStart,
    void Function()? onLoadingEnd,
    ValueNotifier<dynamic>? responseNotifier,
  }) async {
    onLoadingStart?.call();

    final timeoutDuration = Duration(seconds: _timeoutSeconds);

    try {
      // --------------------------------------------------
      // RESOLVE PATH PARAMS (e.g. {systemid} -> 12)
      // --------------------------------------------------
      String resolvedEndpoint = endpoint;
      if (pathParams != null) {
        pathParams.forEach((key, value) {
          resolvedEndpoint = resolvedEndpoint.replaceAll('{$key}', value);
        });
      }

      Uri uri = Uri.parse("$baseUrl$resolvedEndpoint");

      // --------------------------------------------------
      // APPEND QUERY PARAMS
      // --------------------------------------------------
      if (queryParams != null && queryParams.isNotEmpty) {
        final stringParams =
            queryParams.map((key, value) => MapEntry(key, value.toString()));
        uri = uri.replace(
          queryParameters: {
            ...uri.queryParameters,
            ...stringParams,
          },
        );
      }

      print("GET API: $uri");

      // Fetch stored access token
      final String? token = await TokenStorage.getAccessToken();

      final Map<String, String> headers = {
        "Accept": "application/json",
        if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
      };

      final http.Response response =
          await http.get(uri, headers: headers).timeout(timeoutDuration);

      print("Response Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      dynamic responseData;
      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        responseData = response.body;
      }

      // Lets UI read the value reactively without await, e.g.
      // ValueListenableBuilder(valueListenable: responseNotifier, ...)
      responseNotifier?.value = responseData;

      // --------------------------------------------------
      // SUCCESS
      // --------------------------------------------------
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (showSuccessNotif) {
          _showNotification(_extractMessage(responseData, "Success"), true);
        }
        successCallback?.call(responseData);
      }

      // --------------------------------------------------
      // FAILED (non-2xx but request completed)
      // --------------------------------------------------
      else {
        if (showFailedNotif) {
          _showNotification(
            _extractMessage(
                responseData, "API call failed: ${response.statusCode}"),
            false,
          );
        }
        failedCallback?.call(responseData);
      }
    } on TimeoutException {
      print("GET API Error: Request timed out after $_timeoutSeconds seconds");
      if (showFailedNotif) {
        _showNotification("Request timed out. Please try again.", false);
      }
      failedCallback?.call(null);
    } catch (e) {
      print("GET API Error: $e");
      if (showFailedNotif) {
        _showNotification("Something went wrong", false);
      }
      failedCallback?.call(null);
    } finally {
      onLoadingEnd?.call();
    }
  }

  static String _extractMessage(dynamic responseData, String fallback) {
    if (responseData is Map && responseData['message'] != null) {
      return responseData['message'].toString();
    }
    return fallback;
  }

  // --------------------------------------------------
  // Placeholder — real notification widget goes here later.
  // Every success/fail path already calls this, so hooking up
  // the real UI later is a one-line change.
  // --------------------------------------------------
  static void _showNotification(String message, bool isSuccess) {
    print(isSuccess ? "[SUCCESS] $message" : "[FAILED] $message");
  }
}