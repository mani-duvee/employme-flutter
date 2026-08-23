import 'package:flutter/material.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget{
  const NavBar({super.key});
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NavBarState();
  }
  @override
Size get preferredSize => const Size.fromHeight(60);
}
class NavBarState extends State<NavBar>{
  @override
  Widget build(BuildContext context) {
    const Title = "My Work Hub";
    // TODO: implement build
    return Container(
      height: 160,
      color: Colors.red,
      padding: EdgeInsets.all(8),
      // margin: EdgeInsets.only(top: 33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){print("hiii");},
            child: Icon(Icons.menu , color: Colors.white,),
          ),
          Text(Title, style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.w500),),
          Badge(
            label: const Text("2"),
//             child: IconButton( onPressed: (){print("notification btn");}, icon: Icon(Icons.notifications) ,color: Colors.white,)
// ,
child: Icon(Icons.notifications,color: Colors.white,),
          )
        ],
      ),
    );
  }
}
