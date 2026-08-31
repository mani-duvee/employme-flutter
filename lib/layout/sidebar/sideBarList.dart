import 'package:flutter/material.dart';
import '../../constants/sidebar_constants.dart';
import '../../widgets/itemFields.dart';

class Sidebarlist extends StatelessWidget {
  const Sidebarlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.6,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: sideBarList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(sideBarList[index]["label"]);
                    Scaffold.of(context).closeDrawer();
                  },
                  child: ItemFiels(
                    labelText: sideBarList[index]["label"],
                    icon: sideBarList[index]["icon"],
                    iconColor: const Color(0xFF155DFC),
                    textColor: const Color(0xFF155DFC),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
