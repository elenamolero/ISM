import 'package:flutter/material.dart';

final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
);

final theme = ThemeData(
  colorSchemeSeed: const Color.fromARGB(255, 0, 140, 255)
);

void main() => runApp(const RegisterUserPage());

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro',
      home: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          title: const Text('Registro'),
          centerTitle: true,
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: UserInputField(
                  text: Text('Introduce el correo'),
                  icon: Icons.email_outlined),
            ),
            Center(
              child: UserInputField(
                  text: Text('Introduce la contraseña'), icon: Icons.password),
            ),
            Center(
              child: UserInputField(
                  text: Text('Repite la contraseña'), icon: Icons.password),
            ),
            Center(child: UserElectionDropdownMenu())
          ],
        ),
      ),
    );
  }
}

class UserElectionDropdownMenu extends StatelessWidget {
  const UserElectionDropdownMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.secondaryHeaderColor,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
        ),
        items: ["Veterinario", "Dueño de un animal"].map((name) {
          return DropdownMenuItem(value: name, child: Text(name));
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }
}

class UserInputField extends StatelessWidget {
  final Text text;
  final IconData icon;

  const UserInputField({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: theme.secondaryHeaderColor,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            hintText: text.data,
            suffixIcon: Icon(icon)),
      ),
    );
  }
}
