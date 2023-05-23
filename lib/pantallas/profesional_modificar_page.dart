import 'package:flutter/material.dart';

class ProMod extends StatefulWidget {
  const ProMod({super.key});

  @override
  State<ProMod> createState() => _ProModState();
}

class _ProModState extends State<ProMod> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("Modificaciones")
      ],
    );
  }
}