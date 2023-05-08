import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

class Home extends StatefulWidget {
  // <-es una extraccion de home:home()
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 100,
                  )),
              const Text(
                "Nombre de Profesional",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Text(
                  "notificaciones",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(12),
                width: 350,
                child: Text(
                  "pacientes",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Text(
                  "datos del usuario",
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0x11838282),
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Text(
                  "cerrar sesión",
                ),
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0x11838282),
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  width: 350,
                  child: Text(
                    "view",
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/view');
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(title: const Text('data')),
      body: FutureBuilder(
          future:
              getPersonas(), // <-llama a la funcion declarada en la carpeta servicion
          builder: (context, snapshot) {
            //<-snapshot recibe getPersonas()
            if (snapshot.hasData) {
              //<-snapshot si no esta NULL lo muestra
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data?[index]['apellido'] +
                        ' ' +
                        snapshot.data?[index]['nombre']),
                    subtitle: Text("[Datos del paciente]"),
                    leading: Icon(
                      Icons.account_circle_outlined,
                      size: 50,
                    ),
                  ); //<-- [saca el dato de la base]
                },
              );
            } else {
              return const Center(
                //<-snapshot si esta NULL
                child: CircularProgressIndicator(), //<-pinta un circulo
              );
            }
          }), 
          
          
          
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      
    );
  }
}
// --------------ROOT APP--------------------------------------

//nom-apellido-telefono-direccion
