import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supermarket_list_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Supermarket list app',
      theme: ThemeData(
          primarySwatch: Colors.blue, textTheme: GoogleFonts.kalamTextTheme()),
      home: Home(),
    );
  }
}
