import 'package:flutter/material.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';

class EditVetInfoPage extends StatefulWidget {
  const EditVetInfoPage({super.key});

  @override
  State<EditVetInfoPage> createState() => _EditVeterinarianInfoPageState();
}

class _EditVeterinarianInfoPageState extends State<EditVetInfoPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController nameBusinessController;
  late TextEditingController cifBusinessController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    nameBusinessController = TextEditingController();
    cifBusinessController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Liberar los controladores
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    nameBusinessController.dispose();
    cifBusinessController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackGround(title: 'Edit Vet Info',isUserLoggedIn: true,),
          Padding(
            padding: const EdgeInsets.all(40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.53),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'Email',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'Address',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Address',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(
                                  Icons.house,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'Phone Number',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'Password',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: nameController,
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                hintText: '••••••••',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'Business Name',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: nameBusinessController,
                              decoration: InputDecoration(
                                hintText: 'Business Name',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(
                                  Icons.business,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'CIF Business',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            TextField(
                              controller: cifBusinessController,
                              decoration: InputDecoration(
                                hintText: 'CIF Business',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: const Icon(
                                  Icons.qr_code,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 224,
                      child: ElevatedButton(
                        onPressed: () {
                          // Aquí se manejaría la acción de guardar los datos
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Changes saved!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(97, 187, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white, width: 2.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 18, color: Colors.white, height: 2),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
