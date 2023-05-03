import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService{
// Google Sing In
registroConGoogle() async{
// Crear la Pantalla interactiva para el registro de Google
final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

// Obtener los detalles de AUTH del request
final GoogleSignInAuthentication gAuth=await gUser!.authentication;

// Crear una credencial para el User
final credencial = GoogleAuthProvider.credential(
  accessToken: gAuth.accessToken,
  idToken: gAuth.idToken,
);

// Realizar el Sing IN por GOOGLE
return await FirebaseAuth.instance.signInWithCredential(credencial);
}
}



