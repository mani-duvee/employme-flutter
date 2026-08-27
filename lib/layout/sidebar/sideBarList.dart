import 'dart:ffi';

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
      {"label": "Attendance", "icon": Icons.fact_check_outlined},
      {"label": "Recommendations", "icon": Icons.recommend_outlined},
      {"label": "Disciplinary Notice", "icon": Icons.warning_amber_outlined},
      {"label": "My Documents", "icon": Icons.description_outlined},
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.6,
       color:  Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0),
              itemCount: sideBarList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    
                    print(sideBarList[index]["label"]);
                     Scaffold.of(context).closeDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          sideBarList[index]["icon"],
                          color: const Color(0xFF155DFC),
                        ),
                        SizedBox(width: 14),
                        Text(
                          sideBarList[index]["label"],
                          style: TextStyle(
                                 color: const Color(0xFF155DFC),

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
