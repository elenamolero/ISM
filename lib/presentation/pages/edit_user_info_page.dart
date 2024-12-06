import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/usecases/edit_user_info.dart';
import '../bloc/edit_user_info_bloc.dart';
import '../../domain/entities/user.dart';

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}


class _EditUserInfoPageState extends State<EditUserInfoPage> {

  Future<Map<String, dynamic>?> fetchUserData() async {
  return await Supabase.instance.client
      .from('User')
      .select()
      .eq('name', 'Arturo')
      .maybeSingle();
  }

  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    data = await fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      // Muestra un indicador de carga si los datos no están listos
      return Scaffold(
        appBar: AppBar(title: const Text('Edit User')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return BlocProvider(
      create: (_) => EditUserInfoBloc(EditUserInfo()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Edit User',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          elevation: 0,
        ),
        body: BlocListener<EditUserInfoBloc, EditUserInfoState>(
          listener: (context, state) {
            if (state is EditUserSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User info saved successfully!')),
              );
            } else if (state is EditUserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<EditUserInfoBloc, EditUserInfoState>(
            builder: (context, state) {
              if (state is EditUserLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: TextEditingController(
                          text: data?['name'] ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Owner Input
                      TextField(
                        controller: TextEditingController(
                            text: data?['email'] ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User Age Input
                      TextField(
                        controller: TextEditingController(
                            text: data?['address'] ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: const Icon(Icons.home),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User Age Input
                      TextField(
                        controller: TextEditingController(
                            text: data?['phoneNumber'].toString() ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User Age Input
                      TextField(
                        controller: TextEditingController(
                            text: data?['password'] ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: 16),
                      // Save Changes Button
                      /* SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Send event to the BLoC
                            context.read<EditUserInfoBloc>().add(
                                  EditUserEvent(User(
                                    name: 'Drako',
                                    email: 'eee',
                                    address: 'oooo',
                                    phoneNumber: 0,
                                    password: 'oooo',
                                    role: 'ooo'
                                  )),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ), */
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}