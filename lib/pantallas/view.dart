import 'package:flutter/material.dart';

class View extends StatefulWidget {
  const View({super.key});

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigator"),
      ),
      body: ListView(
        children: <Widget>[
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
                    "Home paciente",
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/homepaciente');
                },
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
                    "Home Profesional",
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
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
                    "Registro Profesional",
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/registropro');
                },
              )
        ],
      ),
    );
  }
    
}