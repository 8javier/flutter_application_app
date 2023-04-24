
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
      appBar: AppBar(title: const Text('Personas')
      ),
      
      body: FutureBuilder(
        future: getPersonas(),         // <-llama a la funcion declarada en la carpeta servicios que trae los datos de la base de datos
        builder:(context, snapshot){ //<-snapshot recibe getPersonas()
        if(snapshot.hasData){//<-snapshot si no esta NULL lo muestra
             return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index){
              return ListTile(
               title: Text(snapshot.data?[index]['apellido']), //<-- [saca el dato de la base]
              onTap: (() async{
                await Navigator.pushNamed(context, '/edit',arguments: 
                {
                  "apellido": snapshot.data?[index]['apellido'],
                  "nombre": snapshot.data?[index]['nombre'],
                  "uid":snapshot.data?[index]['uid'],//<-- [saca el ID de la base]
                });
                setState(() {
                  //<--  A ctualiza los cambios con los de la base
                });
              })
              );
            },
          );
          
        } else{return const Center(//<-snapshot si esta NULL 
          child: CircularProgressIndicator(),//<-pinta un circulo
        );
        
        }
        }),
        floatingActionButton: FloatingActionButton(
            onPressed: ()async{                      //<-agrega un async por que se interactua con la base de datos
            await Navigator.pushNamed(context, '/add');//<-agrega await para que pause la sincronia con la base y hace una actualizacion de los datos que hay en la base
            print('sigo ejecutando el Home');  //<-compruevo si paro en la debug console
            setState(() {});   //<-- actualiza la info del Home_page para que muestre los datos da la base de datos
        },
        child: const Icon(Icons.add),
        ),
        
    );
  }
}
// --------------ROOT APP--------------------------------------









//nom-apellido-telefono-direccion
