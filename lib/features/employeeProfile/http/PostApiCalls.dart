import 'dart:convert';
import 'package:http/http.dart' as http;

class PostApiCalls {
  // Default Base URL
  static const String baseUrl =
      "http://192.168.1.14:8081/api/v1/";

  /// Common POST API Call
  ///
  /// [endpoint]      -> API endpoint, example: "emp/home"
  /// [data]          -> Request body
  /// [successCallback] -> Called when API succeeds
  /// [successMessage] -> Message printed on success
  /// [formData]      -> If true, sends multipart/form-data
  /// [failedMessage] -> Message printed when API fails
  static Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? data,
    Function(dynamic response)? successCallback,
    String? successMessage,
    bool formData = false,
    String? failedMessage,
  }) async {
    try {
      final String url = "$baseUrl$endpoint";

      print("POST API: $url");
      print("Request Data: $data");

      http.Response response;

      // --------------------------------------------------
      // FORM DATA
      // --------------------------------------------------
      if (formData) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(url),
        );

        if (data != null) {
          data.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        var streamedResponse = await request.send();

        response = await http.Response.fromStream(
          streamedResponse,
        );
      }

      // --------------------------------------------------
      // JSON
      // --------------------------------------------------
      else {
        response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(data ?? {}),
        );
      }

      // --------------------------------------------------
      // PRINT RESPONSE
      // --------------------------------------------------

      print("Response Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      dynamic responseData;

      try {
        responseData = jsonDecode(response.body);
      } catch (e) {
        responseData = response.body;
      }

      // --------------------------------------------------
      // SUCCESS
      // --------------------------------------------------

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        print(
          successMessage ?? "API call successful",
        );

        if (successCallback != null) {
          successCallback(responseData);
        }

        // Return response to caller
        return responseData;
      }

      // --------------------------------------------------
      // FAILED
      // --------------------------------------------------

      print(
        failedMessage ??
            "API call failed: ${response.statusCode}",
      );

      return responseData;
    } catch (e) {
      print("POST API Error: $e");

      print(
        failedMessage ?? "Something went wrong",
      );

      return null;
    }
  }
}