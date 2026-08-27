import 'package:flutter/material.dart';

class SideBarAvatharProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const profileData={"employeeName":"Mani","phoneNumber":"9361122418","employeeMail":"ceitmanikandan24@gmail.com"};
    // TODO: implement build
    
    return 
       Container(
                      color: const Color(0xFF155DFC),

                  height: MediaQuery.of(context).size.height /4, width:  MediaQuery.of(context).size.width ,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    // width: double.infinity,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.only(top:20, left:10),
                        child: ClipOval(
                          child: Image(image: AssetImage("assets/images/IMG_0556.jpg"),fit: BoxFit.cover,),
                          
                        ),
                       // alignment: Alignment(0, 0),
                        height: 70, width: 70, 
                        decoration:BoxDecoration(
                              

                          shape: BoxShape.circle
                          
                        ) ,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(profileData["employeeName"]!,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 13),overflow: TextOverflow.ellipsis,),
                       Text(profileData["phoneNumber"]!,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 13),overflow: TextOverflow.ellipsis,),
                      Text(profileData["employeeMail"]!,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 13),overflow: TextOverflow.ellipsis,),
                     
                    ],
                  ),
                
    );
  }
}