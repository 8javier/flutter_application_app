import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/provider/authProvider.dart';
import '../modelos/provider/registration_provider.dart';
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specialization  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
           TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa un email';
            }
            // Puedes agregar más validaciones según tus necesidades
            return null;
          },
        ),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Contraseña'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa una contraseña';
            }
            // Puedes agregar más validaciones según tus necesidades
            return null;
          },
        ),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Nombre'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa un nombre';
            }
            // Puedes agregar más validaciones según tus necesidades
            return null;
          },
        ),
        TextFormField(
          controller: _specialization,
          decoration: InputDecoration(labelText: 'Especialización'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa una especialización';
            }
            // Puedes agregar más validaciones según tus necesidades
            return null;
          },
        ),
          // Construye los campos de entrada de datos aquí

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final email = _emailController.text;
                final password = _passwordController.text;
                final name = _nameController.text;
                final rol=_specialization.text;
                registrationProvider.registerUser(
                  email: email,
                  password: password,
                  name: name, 
                  specialization: rol,         
                );
              }
            },
     
            child: const Text('Registrarse'),
          ),
        ],
      ),
    );
  }
}
