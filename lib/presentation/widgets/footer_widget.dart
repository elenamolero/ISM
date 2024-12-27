import 'package:flutter/material.dart';
import 'package:petuco/presentation/pages/users/edit_user_info_page.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Container principal con borde blanco
        Container(
          height: 60,
          width: double.infinity,
          decoration:const  BoxDecoration(
            color:  Color(0xFF1B96F4),
            border:  Border(
              top: BorderSide(color: Colors.white, width: 3),
              left: BorderSide(color: Colors.white, width: 3),
              right: BorderSide(color: Colors.white, width: 3),
            ),
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(10), 
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: -30,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditUserInfoPage(),
                ),
              );
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF1B96F4),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
