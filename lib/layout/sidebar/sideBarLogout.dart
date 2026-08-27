import 'package:flutter/material.dart';

class SideBarLogout extends StatelessWidget {
  const SideBarLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18, bottom: 0),
        height: MediaQuery.of(context).size.height,
        width: screenWidth > 600 ? screenWidth / 5 : screenWidth / 1.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.logout, color: Color(0xFF155DFC)),
            const SizedBox(width: 10),
            const Text(
              "Logout",
              style: TextStyle(
                color: const Color(0xFF155DFC),

                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
