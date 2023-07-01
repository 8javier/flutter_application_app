import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelos/paciente_datos.dart';
import '../modelos/provider/profesional_provider.dart';
class ListaPacientePage extends StatefulWidget {
  const ListaPacientePage({super.key});
  @override
  State<ListaPacientePage> createState() => _ListaPacientePageState();
}
class _ListaPacientePageState extends State<ListaPacientePage> {
 @override
  void initState() {
    super.initState();
    // Carga los pacientes del profesional al iniciar la página
    final profesionalProvider = Provider.of<ProfesionalProvider>(context, listen: false);
    profesionalProvider.cargarPacientesLista();
  }

  @override
  Widget build(BuildContext context) {
    final profesionalProvider = Provider.of<ProfesionalProvider>(context);
    final List<Paciente> pacientes = profesionalProvider.pacientesLista;
      return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pacientes'),
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          final paciente = pacientes[index];
          return ListTile(
            title: Text(paciente.nombre ?? ''),
            subtitle: Text(paciente.apellido ?? ''),
            // Agrega cualquier otra información adicional que quieras mostrar del paciente
          );
        },
      ),
    );
  }
}