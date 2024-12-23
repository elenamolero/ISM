import 'package:flutter/material.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';

class CreateHealthView extends StatefulWidget {
  const CreateHealthView({super.key});

  @override
  State<CreateHealthView> createState() => _CreateHealthViewState();
}

class _CreateHealthViewState extends State<CreateHealthView> {
  TextEditingController dateController = TextEditingController();

  // Función para abrir el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackGround(title: "Health Test"),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: GlobalKey<FormState>(),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.53),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomText(text: "Type"),
                      const SizedBox(height: 10),
                      const CustomTextField(
                        labelText: "Vaccine",
                        icon: Icons.type_specimen_outlined,
                      ),
                      const SizedBox(height: 20),
                      const CustomText(text: "Description"),
                      const SizedBox(height: 10),
                      const CustomTextField(
                        labelText: "Covid Vaccine",
                        icon: Icons.description_outlined,
                      ),
                      const SizedBox(height: 20),
                      const CustomText(text: "Place"),
                      const SizedBox(height: 10),
                      const CustomTextField(
                        labelText: "Cordoba Vet",
                        icon: Icons.place_outlined,
                      ),
                      const SizedBox(height: 20),
                      const CustomText(text: "Date"),
                      const SizedBox(height: 10),
                      CustomTextField(
                        labelText: "Select Date",
                        icon: Icons.date_range_outlined,
                        controller: dateController,
                        onTap: () => _selectDate(
                            context), // Activar el selector de fecha
                        keyboardType:
                            TextInputType.none, // Deshabilitar teclado
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Información guardada")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(97, 187, 255, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                  color: Colors.white, width: 2.0),
                            ),
                          ),
                          child: const CustomText(text: "Save"),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: FooterWidget(),
                      ),
        ],
      ),
    );
  }
}
