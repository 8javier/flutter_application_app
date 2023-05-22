import 'package:flutter/material.dart';


Widget texto(){
  return TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  isDense: true,
                  hintStyle:
                      TextStyle(letterSpacing: 2, color: Color(0xff000000)),
                  fillColor: Color(0xffffffff),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  /* icon: Icon(Icons.draw_outlined), */
                ),
              );
}