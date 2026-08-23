import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget{
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width/1.8,
      height: MediaQuery.of(context).size.height,
    );
  }
}