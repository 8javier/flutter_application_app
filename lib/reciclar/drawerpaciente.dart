import 'package:flutter/material.dart';

Widget drawerpaciente(contexto){
  return Drawer(
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
                "Nombre Paciente",
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
                  "Notificaciones",
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
                  "Historial",
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
                  Navigator.pushNamed(contexto, '/view');
                },
              ),
            ],
          ),
        ),
      );
}

/*  */