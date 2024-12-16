import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';

const String _petname = "Fentanyl Jr.";

class PetMedicalHistorialPage extends StatelessWidget {
  const PetMedicalHistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        const BackGround(title: 'Historial médico'),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: screenHeight*0.13),
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: const Opacity(
                opacity: 0.69,
                child: Text("Informes médicos de $_petname",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: String.fromEnvironment('InriaSans')
                    )
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  MedicalOperationBox(
                      type: 'Operacion',
                      description:
                          'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                      date: DateTime.now(),
                      place: 'Alice in the Wonderlands'),
                  MedicalOperationBox(
                      type: 'Operacion',
                      description:
                          'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                      date: DateTime.now(),
                      place: 'Alice in the Wonderlands'),
                      MedicalOperationBox(
                      type: 'Operacion',
                      description:
                          'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                      date: DateTime.now(),
                      place: 'Alice in the Wonderlands'),
                      MedicalOperationBox(
                      type: 'Operacion',
                      description:
                          'Cillum excepteur tempor cillum aliqua fugiat. Et enim nisi sit ex ipsum officia nulla ipsum adipisicing incididunt ea magna voluptate.',
                      date: DateTime.now(),
                      place: 'Alice in the Wonderlands')
                ],
              ),
            ))
          ],
        )
      ],
    ));
  }
}

class MedicalOperationBox extends StatelessWidget {
  final String type;
  final String description;
  final DateTime date;
  final String place;

  const MedicalOperationBox({
    super.key,
    required this.type,
    required this.description,
    required this.date,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    const TextStyle textStyle = TextStyle(
      fontFamily: String.fromEnvironment('InriaSans'),
      fontSize: 14,
      color: Color.fromARGB(255, 0, 50, 92)
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.53),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  style: textStyle,
                  children: [
                    const TextSpan(
                      text: '• TIPO: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: type),
                  ]),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                  style: textStyle,
                  children: [
                    const TextSpan(
                      text: '• DESCRIPCIÓN: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: description),
                  ]),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                  style: textStyle,
                  children: [
                    const TextSpan(
                      text: '• FECHA: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: formattedDate)
                  ]),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                  style: textStyle,
                  children: [
                    const TextSpan(
                      text: '• LUGAR: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: place),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
