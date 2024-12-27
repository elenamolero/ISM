import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petuco/di/dependency_injection.dart';
import 'package:petuco/domain/entities/healthTest.dart' as healthTest;
import 'package:petuco/domain/usecases/impl/save_health_test_info_use_case.dart';
import 'package:petuco/presentation/blocs/healthTests/create_health_test_bloc.dart';
import 'package:petuco/presentation/pages/pet_medical_historial_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_widget.dart';
import 'package:petuco/presentation/widgets/custom_text_field_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
class CreateHealthView extends StatefulWidget {
  final int petId;

  const CreateHealthView({Key? key, required this.petId}) : super(key: key);

  @override
  State<CreateHealthView> createState() => _CreateHealthViewState();
}

class _CreateHealthViewState extends State<CreateHealthView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    typeController.dispose();
    descriptionController.dispose();
    placeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateHealthTestInfoBloc(
        createHealthTestUseCase: appInjector.get<SaveHealthTestInfoUseCase>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackGround(title: "Health Test"),
            BlocListener<CreateHealthTestInfoBloc, CreateHealthTestInfoState>(
              listener: (context, state) {
                if (state is CreateHealthTestSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Health Test saved")),
                  );
                } else if (state is CreateHealthTestError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<CreateHealthTestInfoBloc, CreateHealthTestInfoState>(
                builder: (context, state) {
                  if (state is CreateHealthTestLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
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
                              CustomTextField(
                                labelText: "Type...",
                                icon: Icons.type_specimen_outlined,
                                controller: typeController,
                              ),
                              const SizedBox(height: 20),
                              const CustomText(text: "Description"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                labelText: "Description...",
                                icon: Icons.description_outlined,
                                controller: descriptionController,
                              ),
                              const SizedBox(height: 20),
                              const CustomText(text: "Place"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                labelText: "Place...",
                                icon: Icons.place_outlined,
                                controller: placeController,
                              ),
                              const SizedBox(height: 20),
                              const CustomText(text: "Date"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                labelText: "Select Date",
                                icon: Icons.calendar_today,
                                controller: dateController,
                                onTap: () => _selectDate(context),
                                keyboardType: TextInputType.none,
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      _createHealthTest(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(97, 187, 255, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(color: Colors.white, width: 2.0),
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
                  );
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
        ),
      ),
    );
  }

  void _createHealthTest(BuildContext context) {
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Date is required')));
      return;
    }
    try {
      final date = DateFormat('dd/MM/yyyy').parse(dateController.text);
      final vetId = Supabase.instance.client.auth.currentUser?.email;
      if (vetId != null) {
        final newHealthTest = healthTest.HealthTest(
          testName: typeController.text,
          description: descriptionController.text,
          place: placeController.text,
          vetId: vetId,
          petId: widget.petId,
          date: date,
        );
        context.read<CreateHealthTestInfoBloc>().add(CreateHealthTestEvent(newHealthTest));
        Navigator.push(
          context,
            MaterialPageRoute(
              builder: (context) =>
                PetMedicalHistorialPage(
              petId: widget.petId,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save health test: $e')));
    }
  }
}