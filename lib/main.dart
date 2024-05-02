import 'package:flutter/material.dart';
import 'package:noteapp/pages/add_page.dart';
import 'package:noteapp/pages/edit_page.dart';
import 'package:noteapp/pages/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    // home: AddNote(),
    // home: EditPage(),
  ));
}
