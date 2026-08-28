import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sample_employee_me/widgets/title.dart';
import '../../widgets/customCard.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  // Edit button
  void editPersonalInfo() {
    print("Edit button clicked");
  }

  // GET Employee Profile API
  Future<void> getEmployeeProfileData() async {
  print("View clicked");

  final url = Uri.parse(
    "http://192.168.1.14:8081/api/v1/emp/profile-info",
  );

  print("Calling API: $url");

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer YOUR_AUTH_TOKEN',
      },
    );

    print("API CALL COMPLETED");
    print("Status Code: ${response.statusCode}");
    print("Response: ${response.body}");
  } catch (e) {
    print("API ERROR: $e");
  }
}
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: const EdgeInsets.only(
        right: 10,
        left: 10,
        top: 5,
      ),
      padding: const EdgeInsets.all(10),
      textColor: Colors.white,
      child: Titles(
        title: "Personal Information",
        action: true,
        edit: true,
        editFunction: editPersonalInfo,
        view: true,
        viewFunction: getEmployeeProfileData,
      ),
    );
  }
}