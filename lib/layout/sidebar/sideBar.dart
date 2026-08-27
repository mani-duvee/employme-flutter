import 'package:flutter/material.dart';
import './sideBarAvatharProfile.dart';
import "./sideBarList.dart";
import './sideBarLogout.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Material(
      elevation: 30,
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.all(0),

        width: screenWidth > 600
            ? MediaQuery.of(context).size.width / 5
            : MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
              SideBarAvatharProfile(),
              Sidebarlist(),
              SideBarLogout()

        ],
      ),
      ),
    );
  }
}
