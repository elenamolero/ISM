import 'package:flutter/material.dart';

final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: BorderSide.none,
);

void main() => runApp(const RegisterUserPage());

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  bool _showVet = false;
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro',
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text('Registro'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(20.0)),
            const UserInputField(
                text: Text('Introduce el correo'), icon: Icons.email_outlined),
            const UserInputField(
                text: Text('Introduce la contraseña'), icon: Icons.password),
            const UserInputField(
                text: Text('Repite la contraseña'), icon: Icons.password),
            const UserInputField(
                text: Text('Introduce tu teléfono'), icon: Icons.phone),
            UserElectionDropdownMenu(
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  _showVet = _selectedValue == 'Veterinario';
                });
              },
            ),
            Visibility(
              visible: _showVet,
              child: const UserInputField(
                  text: Text('Introduce el nombre del negocio'),
                  icon: Icons.business),
            ),
            Visibility(
              visible: _showVet,
              child: const UserInputField(
                  text: Text('Introduce el CIF del negocio'),
                  icon: Icons.document_scanner_outlined),
            ),
            const Spacer(),
            const RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
          style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2)),
          onPressed: () {},
          child: const Text('Registrarse')),
    );
  }
}

class UserElectionDropdownMenu extends StatelessWidget {
  final ValueChanged<String?> onChanged;

  const UserElectionDropdownMenu({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
          ),
          items: ["Veterinario", "Dueño de un animal"].map((name) {
            return DropdownMenuItem(value: name, child: Text(name));
          }).toList(),
          onChanged: onChanged,
        ));
  }
}

class UserInputField extends StatelessWidget {
  final Text text;
  final IconData icon;

  const UserInputField({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            hintText: text.data,
            suffixIcon: Icon(icon)),
      ),
    );
  }
}
