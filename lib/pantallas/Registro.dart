import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffd9d9d9),
          title: Center(
            child:
                Text("Registrar", style: TextStyle(color: Color(0xff838282))),
          )),
      body: cuerpo(),
    );
  }
}

Widget cuerpo() {
  return Container(
      child: Center(
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      nombre(),
      campo("Nombre"),
      campo("Apellido"),
      campo("Teléfono"),
      campo("DNI"),
      campo("Matrícula"),
      _botonAceptar(40, 75),
    ]),
  ));
}

Widget nombre() {
  return Text("Registrarse",
      style: TextStyle(color: Color(0xff838282), fontSize: 35.0));
}

Widget campo(String nombre) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        hintText: nombre,
        fillColor: Color(0xffffffff),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
      ),
    ),
  );
}

Widget _botonAceptar(double _height, double _width) {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    minimumSize: Size(_width, _height),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: Color(0xff838282),
    padding: EdgeInsets.all(0),
  );
  return TextButton(
    /* style: flatButtonStyle, */
    onPressed: () {},
    child: Text("Registrar", style: TextStyle(color: Color(0xffffffff))),
  );
}
