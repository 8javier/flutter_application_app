
import 'package:flutter/material.dart';
import 'package:flutter_application_app/servicios/firebase_service.dart';

class Home extends StatefulWidget {// <-es una extraccion de home:home()
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
      appBar: AppBar(title: const Text('data')
      ),
      
      body: FutureBuilder(
        future: getPersonas(),         // <-llama a la funcion declarada en la carpeta servicion
        builder:(context, snapshot){ //<-snapshot recibe getPersonas()
        if(snapshot.hasData){//<-snapshot si no esta NULL lo muestra
             return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index){
              return Text(snapshot.data?[index]['apellido']); //<-- [saca el dato de la base]
            },
          );
          
        } else{return const Center(//<-snapshot si esta NULL 
          child: CircularProgressIndicator(),//<-pinta un circulo
        );
        
        }
        }),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
            Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
        ),
        
    );
  }
}
// --------------ROOT APP--------------------------------------









//nom-apellido-telefono-direccion
