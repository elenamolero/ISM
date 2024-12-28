import 'package:flutter/material.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';

class AsignPetPage extends StatefulWidget {
  @override
  _AsignPetPageState createState() => _AsignPetPageState();
}

class _AsignPetPageState extends State<AsignPetPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BackGround(title: "Asign a pet",isUserLoggedIn: true,),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              "Find your new client",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: const String.fromEnvironment("Inter"),
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.8)),
            ),
          ),
        ),
        Positioned(
          top: 175,
          left: 20,
          right: 20,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter the phone number of your client',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
            ),
            onSubmitted: (value) {
              //asignarpets
            },
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: FooterWidget(),
        ),
      ],
    ));
  }

}
