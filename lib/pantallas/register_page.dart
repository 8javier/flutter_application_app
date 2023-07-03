import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_app/componentes/boton_1.dart';
import 'package:flutter_application_app/componentes/campo_texto.dart';
import 'package:flutter_application_app/componentes/encuadre_img.dart';
import 'package:flutter_application_app/reciclar/estado.dart';
import '../modelos/auth.dart';
import '../servicios/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

// ----------------[ Controladores de Texto]-----------
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarPasswordController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final celularController = TextEditingController();
  final dniController = TextEditingController();
  final tipoUserController = TextEditingController();
  // -------- Crear_Usuario_Up metodo -----------

  void signUserUp() async {
    // muestra un circulo de espera hasta q responda la base
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // trata de Registro un nuevo usuario !! PONER !===> ALGO Q COMPROEVE EL TIPO DE USER QUE SE ESTA POR REGISTRAR !!
     /* 
      if (_userType == 'doctor') {
          await _firestore.collection('doctors').doc(user.uid).set({
            'email': email,
            'userType': userType,
            // Otros datos específicos del doctor...
          });
        } else if (_userType == 'patient') {
          await _firestore.collection('patients').doc(user.uid).set({
            'email': email,
            'userType': userType,
            // Otros datos específicos del paciente...
          });
        }
    */
    try {
      // confirma q la Password ingresadas coinciden y lo manda a la base a cargar los datos ingresados <--- AGREGAR MODIFICACION ACA !! CON UN [IF]
      if (passwordController.text == confirmarPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        ); 
 
        String user_id = FirebaseAuth.instance.currentUser!.uid;  
        if(tipoUserController.text.toLowerCase() == 'profesional'){  // ------ si es Profesional
                addUserDataProfesional(
                  nombreController.text,
                  apellidoController.text,
                  celularController.text,
                  dniController.text,
                  emailController.text,
                  user_id,
                  tipoUserController.text,     
                );
        } 
        else if(tipoUserController.text.toLowerCase() == 'paciente'){
              addUserData(  // ------ si es Paciente
                nombreController.text,
                apellidoController.text,
                celularController.text,
                dniController.text,
                emailController.text,
                user_id,
                tipoUserController.text,
                0,
                [],
                [],
              );
            }
      } 
      
      else {
        errorMensaje('Las contraseñas no coinciden');
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorMensaje(e.code);
    }
  }



  // ------ funcion Agrega los datos del Paciente a la base con sus Datos  -----------
  Future addUserData(String nombre, String apellido, String celular, String dni,
      String email,String uid,String rol,int estado, List<String> encuestasVinculadas, List<String> preguntasVinculadas) async {
    await FirebaseFirestore.instance.collection("paciente").doc(uid).set({
      'id':uid,
      'uid':uid,
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'dni': dni,
      'email': email,
      'rol': rol,
      'estado': estado,
      'encuestasVinculadas': encuestasVinculadas,
      'preguntasVinculadas': preguntasVinculadas
    });
    creaColeccionDiarioDelPaciente(uid);
    creaColeccionEstadoAnimo(uid);
  }
    // ------ funcion Agrega los datos del Profesional a la base con sus Datos  -----------
  Future addUserDataProfesional(String nombre, String apellido, String celular, String dni,
      String email,String uid,String rol) async {
    await FirebaseFirestore.instance.collection("profesional").doc(uid).set({
      'id':uid,
      'uid':uid,
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'dni': dni,
      'email': email,
      'rol': rol,
    });
  }

  // ------ funcion Agrega al Paciente la coleccion [diario] relacionada con el uid de Auth con el id del Paciente -----------
Future<void> creaColeccionDiarioDelPaciente(String uid) async{
    final pacienteDiarioRef=FirebaseFirestore.instance.collection("pacientes/$uid/diarios"); // <-USAR MISMA LOGICA PARA ALMACENAR LOS DEMAS DATOS !!!
    await pacienteDiarioRef.doc().set({});
      print('La colección "Diario" ha sido creada con éxito.');
  }
    // --[Funcion que agrega datos al diario]
  Future<void> agregarDatosDiario(String uid, String titulo, String contenido) async {
  final diariosCollectionRef = FirebaseFirestore.instance.collection('pacientes/$uid/diarios');
  final nuevoDiarioDocRef = diariosCollectionRef.doc(); // Genera un ID automático para el nuevo documento
  await nuevoDiarioDocRef.set({
    'titulo': titulo,
    'contenido': contenido,
    'fecha': DateTime.now(),
  });
  print('Datos del diario agregados con éxito.');
}
// ------ funcion Agrega al Paciente la coleccion [Estado de Animo] relacionada con el uid de Auth con el id del Paciente
Future<void> creaColeccionEstadoAnimo(String uid) async {
  final estadoAnimoCollectionRef = FirebaseFirestore.instance.collection('pacientes/$uid/estado_animo');
  await estadoAnimoCollectionRef.doc().set({});
   print('La colección "estado_animo" ha sido creada con éxito.');
  }
      // --[Funcion que agrega datos a la coleccion Estado de animo]
  Future<void> agregarDatosEstadoAnimo(String uid, DateTime fecha, String emocion) async {
  final estadoAnimoCollectionRef = FirebaseFirestore.instance.collection('pacientes/$uid/estado_animo');
  final nuevoEstadoAnimoDocRef = estadoAnimoCollectionRef.doc(); // Genera un ID automático para el nuevo documento
  await nuevoEstadoAnimoDocRef.set({
    'fecha': fecha,
    'emocion': emocion,
  });
  print('Datos de estado de ánimo agregados con éxito.');
}
// ------------------------------------------------------------------------------------------------------------
  // ------ funcion Mensaje de Alerta -----------
  void errorMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 231, 165, 222),
          title: Center(
            child: Text(
              mensaje,
              style: const TextStyle(color: Colors.purple),
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 163, 211),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                // logo----------------------------------------
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 25),
                // texto de bienvenida-------------------------
                const Text(
                  'Crea tu cuenta',
                  style: TextStyle(color: Color.fromARGB(255, 238, 229, 229), fontSize: 16),
                ),
                const SizedBox(height: 25),
                // email textfield------------------------------
                CampoTexto(
                  controller: nombreController,
                  hinttext: 'Nombre',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // email textfield------------------------------
                CampoTexto(
                  controller: apellidoController,
                  hinttext: 'Apellido',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // email textfield------------------------------
                CampoTexto(
                  controller: celularController,
                  hinttext: 'Celular',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // email textfield------------------------------
                  // email textfield------------------------------
                CampoTexto(
                  controller: dniController,
                  hinttext: 'Dni',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // email textfield------------------------------
                CampoTexto(
                  controller: emailController,
                  hinttext: 'Email',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // Tipo de Usuario textfield------------------------------
                CampoTexto(
                  controller: tipoUserController,
                  hinttext: 'Tipo de Usuario ',
                  textObscuro: false,
                ),
                const SizedBox(height: 10),
                // password textfield--------------------------
                CampoTexto(
                  controller: passwordController,
                  hinttext: 'Contraseña',
                  textObscuro: true,
                ),
                const SizedBox(height: 10),
                // Confirmar password textfield--------------------------
                CampoTexto(
                  controller: confirmarPasswordController,
                  hinttext: 'Repetir contraseña',
                  textObscuro: true,
                ),
                const SizedBox(height: 10),

                // sing in boton------------------------------
                Boton(
                  texto: 'Registrarse',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 10),
                // o continuar con...------------------------
                const Divider(
                  thickness: 5,
                  color: Colors.pinkAccent,
                ),
                // google \\ o otros
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EncuadreImg(
                        onTap: () => AuthService()
                            .registroConGoogle(), // <-- verrr SignIn
                        imagenesPath: 'lib/imagenes/google.png'),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),

                // registrar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ya tienes una cuenta?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Registrarse ahora',
                        style: TextStyle(
                            color: Color.fromARGB(255, 27, 29, 31), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
