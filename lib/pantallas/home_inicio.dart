import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class HomeInicio extends StatelessWidget {
  HomeInicio({super.key});
  //---------[ Funcion de logOut de firebase ]
void signUserOut(){
  FirebaseAuth.instance.signOut();
}

final user = FirebaseAuth.instance.currentUser!;
//--------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],),
      body:  Center(
        child: Text(
          "Logged IN!" + user.email!,
          style: TextStyle(fontSize: 20),
          )),
    );
  }
}