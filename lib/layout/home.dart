import 'dart:math';

import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Title = "My Work Hub";
    final List<Map<Object, Object>> sideBarList = [
      {"label": "My Profile", "icon": Icons.person_outline},
      {"label": "My Organization", "icon": Icons.business_outlined},
      {"label": "Search Company", "icon": Icons.search},
      {"label": "My Achievements", "icon": Icons.emoji_events_outlined},
      {"label": "My Feedback", "icon": Icons.chat_bubble_outline},
      {"label": "Leave Management", "icon": Icons.calendar_today_outlined},
      {"label": "Disciplinary Notice", "icon": Icons.warning_amber_outlined},
      {"label": "My Documents", "icon": Icons.description_outlined},
    ];
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // foregroundColor:  Colors.blue
        elevation: 20,
        title: const Text(
          Title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print("this for the notification bell can click!!");
            },
            icon: Icon(Icons.notifications_active, size: 17),
          ),
        ],
        // leading:const Icon(Icons.menu)
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.7,
        elevation: 20,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Manikandan"),
              accountEmail: Text("data"),
              currentAccountPicture: CircleAvatar(
                // backgroundImage:  AssetImage("assets/images/IMG_0556.jpg"),
                backgroundImage:  ExactAssetImage("assets/images/IMG_0556.jpg"),
              ),
            ),

            ColoredBox(
                  color: Colors.red,
              child: SizedBox(height: 2000,
                child: ListView(
                  children: sideBarList.map((item) {
                    return ListTile(
                      leading: Icon(item["icon"] as IconData),
                      title: Text(item["label"] as String,style: TextStyle(fontSize: 13),),
                      onTap: () {
                        print(item["label"]);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Hello Flutter', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
