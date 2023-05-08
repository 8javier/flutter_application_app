import 'package:flutter/material.dart';


class RegistroProfesional extends StatefulWidget {

  @override
  _RegistroProfesionalState createState() => _RegistroProfesionalState();
  
}
class _RegistroProfesionalState extends State<RegistroProfesional>{
  bool? _acceptedTerms = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: ListView(
        children: <Widget>[
          Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 42.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 42.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Matrícula',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 42.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 42.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),

              CheckboxListTile(
                title: const Text('GeeksforGeeks'),
                  value: _acceptedTerms,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _acceptedTerms = newValue;
                    });
                  },
              ),
              SizedBox(height: 42.0),
              ElevatedButton(
                onPressed: () {
                  
                },
                child: Text('Aceptar'),
              ),
            ],
          ),
        ),
      ),
        ],
      )
      
    )
    );
  }
}
