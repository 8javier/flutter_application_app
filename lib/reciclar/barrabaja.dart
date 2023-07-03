import 'package:flutter/material.dart';

class DemoBottomAppBar extends StatefulWidget {
  const DemoBottomAppBar({
    super.key
  });

  @override
  State<DemoBottomAppBar> createState() => DemoBottomAppBarState();

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
}

class DemoBottomAppBarState extends State<DemoBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xff0047ab),
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'lista de profesionales',
              icon: const Icon(Icons.list_alt_sharp),
              onPressed: () async {
          await Navigator.pushNamed(context, '/lisProfesional');
          setState(() {});
        },
            ),
            
            IconButton(
              tooltip: 'añadir paciente',
              icon: const Icon(Icons.accessibility_new),
              onPressed: () async {
          await Navigator.pushNamed(context, '/addPaciente');

          setState(() {});
        },
            ),
            IconButton(
              tooltip: 'añadir profesional',
              icon: const Icon(Icons.add),
              onPressed: () async {
          //<-agrega un async por que se interactua con la base de datos
          await Navigator.pushNamed(context,
              '/addProfesional'); //<-agrega await para que pause la sincronia con la base y hace una actualizacion de los datos que hay en la base aca va '/add' de paciente

          setState(
              () {}); //<-- actualiza la info del Home_page para que muestre los datos da la base de datos
        },
            ),
          ],
        ),
      ),
    );
  }
}