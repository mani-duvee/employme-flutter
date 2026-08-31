import 'package:flutter/material.dart';
import '../../widgets/customCard.dart';
import '../../widgets/title.dart';
import '../../widgets/itemFields.dart';

class PersonalInfo extends StatelessWidget {
  final Map<String, dynamic>? profileData;

  PersonalInfo({super.key, this.profileData});

  // 1. Variable for Icons
  final Map<String, IconData> fieldIcons = {
    'fullName': Icons.person_outline,
    'dateOfBirth': Icons.calendar_today_outlined,
    'phoneNumber': Icons.phone_outlined,
    'email': Icons.email_outlined,
    'bloodGroup': Icons.favorite_border,
    'languages': Icons.person_outline,
    'currentCity': Icons.location_on_outlined,
  };

  @override
  Widget build(BuildContext context) {
    // API Data from prop (dynamic only)
    final apiData = profileData ?? {};

    final String firstName = apiData['firstName']?.toString() ?? '';
    final String lastName = apiData['lastName']?.toString() ?? '';
    final String fullName = "$firstName $lastName".trim();

    final String dateOfBirth = apiData['dateOfBirth']?.toString() ?? '';
    final String phoneNumber = apiData['phoneNumber']?.toString() ?? '';
    final String email = apiData['email']?.toString() ?? '';
    final String bloodGroup = apiData['bloodGroup']?.toString() ?? '';

    // Format languages list
    final List<dynamic>? languagesList = apiData['languagesKnown'] as List<dynamic>?;
    final String languages = (languagesList != null && languagesList.isNotEmpty)
        ? languagesList.join(', ')
        : '';

    // Format current city & state
    final Map<String, dynamic>? currentAddress =
        apiData['currentAddress'] as Map<String, dynamic>?;
    final String city = currentAddress?['city']?.toString() ?? '';
    final String state = currentAddress?['state']?.toString() ?? '';
    final String currentCity = [city, state].where((s) => s.isNotEmpty).join(', ');

    return CustomCard(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Titles(
            title: "Personal Information",
            icon: Icons.person_outline,
            iconColor: const Color(0xFF0D9488),
            textColor: const Color(0xFF1E293B),
            padding: const EdgeInsets.only(bottom: 12),
          ),
          const SizedBox(height: 8),

          // FULL NAME
          ItemFiels(
            icon: fieldIcons['fullName'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'FULL NAME',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: fullName.isNotEmpty ? fullName : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // DATE OF BIRTH
          ItemFiels(
            icon: fieldIcons['dateOfBirth'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'DATE OF BIRTH',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: dateOfBirth.isNotEmpty ? dateOfBirth : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // PHONE NUMBER
          ItemFiels(
            icon: fieldIcons['phoneNumber'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'PHONE NUMBER',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: phoneNumber.isNotEmpty ? phoneNumber : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // EMAIL
          ItemFiels(
            icon: fieldIcons['email'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'EMAIL',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: email.isNotEmpty ? email : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // BLOOD GROUP
          ItemFiels(
            icon: fieldIcons['bloodGroup'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'BLOOD GROUP',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: bloodGroup.isNotEmpty ? bloodGroup : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // LANGUAGES
          ItemFiels(
            icon: fieldIcons['languages'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'LANGUAGES',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: languages.isNotEmpty ? languages : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // CURRENT CITY
          ItemFiels(
            icon: fieldIcons['currentCity'],
            iconColor: Colors.grey.shade400,
            iconSize: 18,
            labelText: 'CURRENT CITY',
            labelTextColor: Colors.grey.shade500,
            labelTextSize: 11,
            valueText: currentCity.isNotEmpty ? currentCity : 'N/A',
            valueTextColor: const Color(0xFF1E293B),
            valueTextSize: 14,
            margin: const EdgeInsets.only(bottom: 4),
          ),
        ],
      ),
    );
  }
}