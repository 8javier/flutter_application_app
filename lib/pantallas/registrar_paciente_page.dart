import 'package:flutter/material.dart';

class RegistrarPaciente extends StatefulWidget {
  const RegistrarPaciente({super.key});

  @override
  State<RegistrarPaciente> createState() => _RegistrarPacienteState();
}

class _RegistrarPacienteState extends State<RegistrarPaciente> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("Patient registrieren")
      ],
    );
  }
}