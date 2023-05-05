import 'package:flutter/material.dart';

class testPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: const Center(
        child: Text(
          'Hello, World!',
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Button 1',
              child: Icon(Icons.add),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Button 2',
              child: Icon(Icons.ac_unit_outlined),
            ),
          ),
            Positioned(
            bottom: 16,
            left: 126,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Button 3',
              child: Icon(Icons.add_moderator_outlined),
            ),
          ),



        ],
      ),
    );
  }
}
