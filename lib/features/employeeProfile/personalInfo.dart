import 'package:flutter/material.dart';
import 'package:sample_employee_me/widgets/title.dart';
import '../../widgets/customCard.dart';

class PersonalInfo extends StatelessWidget{
  const PersonalInfo({super.key});
  
  @override
  Widget build(BuildContext context) {
    void Manikandan(){
      print("edit btn clicked");
    }
    // TODO: implement build
    return CustomCard(
      
      // backgroundColor: Colors.red,
      margin: EdgeInsets.only(right:10,left:10,top:5 ),
      padding: EdgeInsets.all(10),
      textColor: Colors.white,
      child: Container(
        child: Titles(title: "title",action: true,edit: true,editFunction: Manikandan,view: true,viewFunction: () {print("object");},),
      ),
      );
  }
}