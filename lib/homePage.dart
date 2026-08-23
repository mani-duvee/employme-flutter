import 'package:flutter/material.dart';
import './widgets/navBar.dart';
import './widgets/sideBar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: NavBar(),
      drawer: Sidebar() ,
    );
  }
}