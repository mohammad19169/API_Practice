import 'package:api_integration/Screens/homescreen.dart';
import 'package:api_integration/Screens/crudcrud.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              secondary: Colors.amber,
              onSecondary: Colors.black,
              error: Colors.red,
              surface: Colors.white)),
      home: const Todowithoutmodel(),
    );
  }
}
