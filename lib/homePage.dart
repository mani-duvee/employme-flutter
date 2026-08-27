import 'package:flutter/material.dart';
import './widgets/navBar.dart';
import './layout/sidebar/sideBar.dart';
import './features/employeeProfile/profilepage.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
 @override
  State<StatefulWidget> createState() {

    return HomePageState();

  }

}
  class HomePageState extends State<HomePage>{

    final GlobalKey<ScaffoldState> openSideBar =GlobalKey<ScaffoldState>();

    @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      key: openSideBar,
      appBar: NavBar(),
      drawer:  Sidebar() ,
      body: Profilepage(),
    );
  }
}
