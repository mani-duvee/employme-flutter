import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PostApiCalls {
  /// Reads BASE_URL from .env (e.g. .env.development / .env.production).
  /// Falls back to the local dev URL if the key is missing.
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? "http://192.168.1.2:8080/api/v1/";

  /// Reads API_CALL_TIME_OUT from .env (seconds). Falls back to 10 if
  /// missing / not a number.
  static int get _timeoutSeconds {
    final raw = dotenv.env['API_CALL_TIME_OUT'];
    return int.tryParse(raw ?? '') ?? 10;
  }

  /// Common POST API Call
  ///
  /// [endpoint]         -> API endpoint, example: "emp/home" or "system/{systemid}"
  /// [pathParams]       -> Optional. Replaces "{key}" placeholders in endpoint.
  /// [data]             -> Required. Request body / payload.
  /// [successCallback]  -> Called with response when API succeeds (2xx). Optional.
  /// [failedCallback]   -> Called with response when API fails / errors. Optional.
  /// [showSuccessNotif] -> Default true. If true, shows the notification widget
  ///                       with `response['message']` on success. Set false to
  ///                       silence it.
  /// [showFailedNotif]  -> Default true. Same, but for failure/error.
  /// [formData]         -> If true, sends multipart/form-data.
  /// [onLoadingStart]   -> Called right before the request starts. Optional.
  /// [onLoadingEnd]     -> Called after success/failure/error. Optional.
  /// [responseNotifier] -> Optional. If passed, gets updated with the parsed
  ///                       response automatically — lets you use the value
  ///                       directly in a widget (via ValueListenableBuilder)
  ///                       without writing your own async/await/setState.
  ///
  /// NOTE: This function handles async/await internally.
  /// Callers should NOT use `await` on this — just call it and pass callbacks.
  static Future<void> post({
    required String endpoint,
    Map<String, String>? pathParams,
    required Map<String, dynamic> data,
    Function(dynamic response)? successCallback,
    Function(dynamic response)? failedCallback,
    bool showSuccessNotif = true,
    bool showFailedNotif = true,
    bool formData = false,
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

      final String url = "$baseUrl$resolvedEndpoint";

      print("POST API: $url");
      print("Request Data: $data");

      http.Response response;

      // --------------------------------------------------
      // FORM DATA
      // --------------------------------------------------
      if (formData) {
        var request = http.MultipartRequest('POST', Uri.parse(url));

        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        var streamedResponse =
            await request.send().timeout(timeoutDuration);
        response = await http.Response.fromStream(streamedResponse);
      }

      // --------------------------------------------------
      // JSON
      // --------------------------------------------------
      else {
        response = await http
            .post(
              Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
              body: jsonEncode(data),
            )
            .timeout(timeoutDuration);
      }

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
            _extractMessage(responseData, "API call failed: ${response.statusCode}"),
            false,
          );
        }
        failedCallback?.call(responseData);
      }
    } on TimeoutException {
      print("POST API Error: Request timed out after $_timeoutSeconds seconds");
      if (showFailedNotif) {
        _showNotification("Request timed out. Please try again.", false);
      }
      failedCallback?.call(null);
    } catch (e) {
      print("POST API Error: $e");
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