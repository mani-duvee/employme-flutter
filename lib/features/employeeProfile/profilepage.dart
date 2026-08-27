import 'package:flutter/material.dart';
import 'package:sample_employee_me/features/employeeProfile/bio.dart';
import './personalInfo.dart';

class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
       // color: Colors.white,
        child: Column(
          children: [
              Bio(),
               PersonalInfo()
          ],
        ),
      );
  }
}