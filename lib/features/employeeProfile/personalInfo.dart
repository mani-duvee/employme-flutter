import 'package:flutter/material.dart';
import '../../widgets/customCard.dart';

class PersonalInfo extends StatelessWidget{
  const PersonalInfo({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomCard(child: Text("data",style: TextStyle(color: Colors.black),));
  }
}