import 'package:flutter/material.dart';

class Sidebarlist extends StatelessWidget {
  const Sidebarlist({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sideBarList = [
      {"label": "My Profile", "icon": Icons.person_outline},
      {"label": "My Organization", "icon": Icons.business_outlined},
      {"label": "Search Company", "icon": Icons.search},
      {"label": "My Achievements", "icon": Icons.emoji_events_outlined},
      {"label": "My Feedback", "icon": Icons.chat_bubble_outline},
      {"label": "Leave Management", "icon": Icons.calendar_today_outlined},
      {"label": "Disciplinary Notice", "icon": Icons.warning_amber_outlined},
      {"label": "My Documents", "icon": Icons.description_outlined},
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sideBarList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    sideBarList[index]["icon"] as IconData,
                  ),
                  title: Text(
                    sideBarList[index]["label"] as String,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}