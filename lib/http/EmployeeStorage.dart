import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeStorage {
  EmployeeStorage._();

  static const String _key = 'employeedetails';

  /// Save full employee details map from login response into SharedPreferences
  static Future<void> saveEmployeeDetails(dynamic response) async {
    if (response is Map && response['data'] is Map) {
      final prefs = await SharedPreferences.getInstance();
      final data = Map<String, dynamic>.from(response['data']);
      await prefs.setString(_key, jsonEncode(data));
    }
  }

  /// Read stored employee details map
  static Future<Map<String, dynamic>?> getEmployeeDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        return jsonDecode(jsonStr) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Get specific employerId from stored employee details
  static Future<String?> getEmployerId() async {
    final details = await getEmployeeDetails();
    return details?['employerId']?.toString();
  }

  /// Get specific userId from stored employee details
  static Future<String?> getUserId() async {
    final details = await getEmployeeDetails();
    return details?['userId']?.toString();
  }

  /// Get specific employeeCode from stored employee details
  static Future<String?> getEmployeeCode() async {
    final details = await getEmployeeDetails();
    return details?['employeeCode']?.toString();
  }

  /// Clear stored employee details (e.g. on logout)
  static Future<void> clearEmployeeDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
